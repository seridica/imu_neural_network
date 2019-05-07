%%%
% File: PartitionSteps.m
% Author: Calvin Kuo
% Date: 03-04-2019
%
% Notes - This function partitions data into steps (based on foot data).
% Actual data is saved on the teamshare (do not put actual data in the
% repository).
%
% XpatchData - Use the Xalign data from either the top of feet or heel
% sensor. Expects two sensor data struct inputs.
% XsensData - Use the Xsens joint angle data (matrix with first column as 
% time vector)

function steps = PartitionSteps( XpatchData, XsensData, tStart, tEnd, partType, threshold )

    % Assert 2 input patch data
    assert( length( XpatchData ) == 2 );
    
    % Assert that the time vectors are matched for xpatches
    assert( length( XpatchData(1).t ) == ...
        sum( XpatchData(1).t == XpatchData(2).t ) );
    
    % Resample the Xsens data
    indStart = find( XpatchData(1).t >= tStart, 1, 'first' );
    indEnd = find( XpatchData(1).t >= tEnd, 1, 'first' );
    t_global = XpatchData(1).t(indStart:indEnd)';
    XsensResample = interp1( XsensData(:,1), XsensData(:,2:end), t_global );
    
    % SMPL angles if needed
    SMPLConversion = zeros( length( XsensResample ), 17*3 );
    for i=1:length( XsensResample )
        [smpl_rot, smpl_angles] = ConvertMVNtoSMPL( XsensResample(i,:) );
        smpl_reorg = smpl_angles([1,2,4,5,16,17,3,6,7,8,11,9,10,12,13,14,15],:);
        SMPLConversion(i,:) = reshape( smpl_reorg', 1, 51 );
    end
    
    % Find Footfall Impacts from sensor 1
    xpatch1_lin_acc = XpatchData(1).lin_acc(indStart:indEnd,:);
    xpatch1_ang_vel = XpatchData(1).ang_vel(indStart:indEnd,:);
    impactList1 = findImpacts( xpatch1_lin_acc(:,1), threshold );
    
    % Find Footfall Impacts from sensor 2
    xpatch2_lin_acc = XpatchData(2).lin_acc(indStart:indEnd,:);
    xpatch2_ang_vel = XpatchData(2).ang_vel(indStart:indEnd,:);
    impactList2 = findImpacts( xpatch2_lin_acc(:,1), threshold );
    
    % Partition Type
    steps = {};
    switch partType
        
        %% Generate steps between impacts (left->left and right->right)
        case 1
            for i=2:length( impactList1 )
                
                % Index bounds for current impact
                ind_start = impactList1(i-1);
                ind_end = impactList1(i);
                
                % Collect data
                t_step = t_global( ind_start:ind_end ) - t_global( ind_start );
                step_data = [t_step, ...
                             xpatch1_lin_acc( ind_start:ind_end,: ), ...
                             xpatch1_ang_vel( ind_start:ind_end,: ), ...
                             xpatch2_lin_acc( ind_start:ind_end,: ), ...
                             xpatch2_ang_vel( ind_start:ind_end,: ), ...
                             SMPLConversion(ind_start:ind_end,: )]; %XsensResample( ind_start:ind_end,: )];
                
                steps = [steps, step_data];
            end
            
            for i=2:length( impactList2 )
                
                % Index bounds for current impact
                ind_start = impactList2(i-1);
                ind_end = impactList2(i);
                
                % Collect data
                t_step = t_global( ind_start:ind_end ) - t_global( ind_start );
                step_data = [t_step, ...
                             xpatch1_lin_acc( ind_start:ind_end,: ), ...
                             xpatch1_ang_vel( ind_start:ind_end,: ), ...
                             xpatch2_lin_acc( ind_start:ind_end,: ), ...
                             xpatch2_ang_vel( ind_start:ind_end,: ), ...
                             SMPLConversion(ind_start:ind_end,: )]; %XsensResample( ind_start:ind_end,: )];
                
                steps = [steps, step_data];
            end
        
        %% Generate steps between impacts (left->left and right->right)
        % Randomly buffer the start and end times
        case 2
            for i=2:length( impactList1 )
                step_data = [];
                steps = [steps, step_data];
            end
            
            for i=2:length( impactList2 )
                step_data = [];
                steps = [steps, step_data];
            end
            
        %% Generate multi-step profiles
        % Step here is considered an impact from left OR right, Multi-step
        % profiles must contain at least two impacts (left and right to get
        % a left->left or right->right gait cycle) and can contain at most
        % 10 impacts (5 left->left or right->right gait cycles).
        case 3
            steps = [];
        %% Generate fixed time step profiles
        case 4
            fixed_len = 2000; % 5 seconds
            curr_ind = 1;
            while ( length( t_global ) - curr_ind ) > fixed_len
                step_data = [t_global(curr_ind:(curr_ind+fixed_len-1)), ...
                             xpatch1_lin_acc(curr_ind:(curr_ind+fixed_len-1),:), ...
                             xpatch1_ang_vel(curr_ind:(curr_ind+fixed_len-1),:), ...
                             xpatch2_lin_acc(curr_ind:(curr_ind+fixed_len-1),:), ...
                             xpatch2_ang_vel(curr_ind:(curr_ind+fixed_len-1),:), ...
                             SMPLConversion(curr_ind:(curr_ind+fixed_len-1),:)]; %XsensResample(curr_ind:(curr_ind+fixed_len),:)];
                curr_ind = curr_ind + fixed_len;
                steps = [steps, step_data];
            end
        %% Simply Return the Full Trace
        case 5
            steps = [];
    end
end

function impactList = findImpacts( lin_acc, threshold )

    % Find all indexes that are greater than the threshold
    thresh_inds = find( lin_acc >= threshold );
    
    % Take the difference of the indices
    diff_inds = diff( thresh_inds );
    
    % Individual impacts are when the difference between indices that
    % exceed threshold are separated by at least 100 (0.25s for 400Hz)
    imp_inds = find( diff_inds > 100 );
    
    % Return impact list
    impactList = thresh_inds( imp_inds );
end