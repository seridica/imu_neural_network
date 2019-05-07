%%%
% File: GenerateDIPData.m
% Author: Calvin Kuo
% Date: 03-11-2019
%
% Script for generating DIP-IMU testing data.

function GenerateDIPData()

    %% SUBJECT 1
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject01\Subject01_12142018\mvn_joint_data.mat')
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject01\Subject01_12142018\mvn_sensor_data.mat')
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject01\Subject01_12142018\mvn_segment_data.mat')
%     start_i = find( sensorData(:,1) >= 450.0, 1, 'first' );
%     end_i = find( sensorData(:,1) >= 710.0, 1, 'first' );
    
    %% SUBJECT 2
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject02\Subject02_12192018\mvn_joint_dat.mat')
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject02\Subject02_12192018\mvn_sensor_dat.mat')
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject02\Subject02_12192018\mvn_segment_dat.mat')
%     start_i = find( sensorData(:,1) >= 220.0, 1, 'first' );
%     end_i = find( sensorData(:,1) >= 380.0, 1, 'first' );

    %% SUBJECT 3
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject03\Subject03_12172018\mvn_joint_dat.mat')
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject03\Subject03_12172018\mvn_sensor_dat.mat')
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject03\Subject03_12172018\mvn_segment_data.mat')
%     start_i = find( sensorData(:,1) >= 455.0, 1, 'first' );
%     end_i = find( sensorData(:,1) >= 500.0, 1, 'first' );

    %% SUBJECT 4
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject04\Subject04_12192018\mvn_joint_dat.mat')
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject04\Subject04_12192018\mvn_sensor_dat.mat')
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject04\Subject04_12192018\mvn_segment_dat.mat')
%     start_i = find( sensorData(:,1) >= 460.0, 1, 'first' );
%     end_i = find( sensorData(:,1) >= 580.0, 1, 'first' );

    %% SUBJECT 5
    load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject05\Subject05_12202018\mvn_joint_dat.mat')
    load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject05\Subject05_12202018\mvn_sensor_dat.mat')
    load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject05\Subject05_12202018\mvn_segment_dat.mat')
    start_i = find( sensorData(:,1) >= 473.0, 1, 'first' );
    end_i = find( sensorData(:,1) >= 650.0, 1, 'first' );
    
    SMPL_R_global = zeros(3,3);
    SMPL_R_global(3,1) = 1; % Global x -> SMPL z
    SMPL_R_global(1,2) = 1; % Global y -> SMPL x
    SMPL_R_global(2,3) = 1; % Global z -> SMPL y
    
    % IMU indices
    imu_root = 1; % Root IMU for normalization
    imu_indices = [10,6,16,13,3]; % Left Wrist, Right Wrist, Left Leg, Right Leg, Head
    seg_indices = [14,10,21,17,7];
    
    % Initial rotation offset - Bone to Sensor transforms according to
    % Xsens
    pelv_quat = sensorData(1,2:5);
    pelv_seg_quat = segmentData(1,2:5);
    
    qrot = quat2rot(pelv_quat);
    prot = quat2rot(pelv_seg_quat);
    %prot = quat2rot(pelv_seg_quat);
    root_off = SMPL_R_global * prot' * qrot;
    
    bone_offsets = zeros(3,3,length(imu_indices));
    for i=1:length( imu_indices )
        sens_quat = sensorData(1,1+(1:7)+7*(imu_indices(i)-1));
        seg_quat = segmentData(1,1+(1:7)+7*(seg_indices(i)-1));
        
        qrot = quat2rot(sens_quat);
        prot = quat2rot(seg_quat);
        %prot = quat2rot(seg_quat);
        if i == 1
            bone_offsets(:,:,i) = SMPL_R_global * prot' * qrot; % * [0,1,0;-1,0,0;0,0,1];
        elseif i == 2
            bone_offsets(:,:,i) = SMPL_R_global * prot' * qrot; % * [0,-1,0;1,0,0;0,0,1];
        else
            bone_offsets(:,:,i) = SMPL_R_global * prot' * qrot;
        end
    end
    
    input_imu_rot = zeros( (end_i-start_i)+1, length( imu_indices )*9 );
    input_imu_acc = zeros( (end_i-start_i)+1, length( imu_indices )*3 );
    ind = 1;
    for i=start_i:end_i
        root_dat = sensorData(i,1+(1:7)+7*(imu_root-1));
        root_quat = root_dat(1:4);
        root_acc = root_dat(5:7);
    
        root_rot = quat2rot(root_quat);
        root_smpl = SMPL_R_global * root_rot * root_off';
        
        for j=1:length( imu_indices )
            imu_dat = sensorData(i,1+(1:7)+7*(imu_indices(j)-1));
            imu_quat = imu_dat(1:4);
            imu_acc = imu_dat(5:7);
            
            imu_rot = quat2rot(imu_quat);
            imu_smpl = SMPL_R_global * imu_rot * bone_offsets(:,:,j)';
            
            SMPL_imu = root_smpl' * imu_smpl;
            
            input_imu_rot(ind,(1:9)+9*(j-1)) = reshape( SMPL_imu', 1, 9 );
            
            %norm_acc = ( SMPL_R_global * ( ( root_imu * imu_acc' ) - root_acc' ) )';
            %norm_acc = ( SMPL_R_global * (root_off*root_rot'*( imu_acc' - root_acc' ) ) )';
            %norm_acc = ( SMPL_R_global * (root_off*root_rot'*( imu_acc' - root_acc' ) ) )'; %((root_off*root_rot'*imu_acc'))';
            %norm_acc = root_smpl' * SMPL_R_global * ( imu_acc' - root_acc' );
            norm_acc = root_smpl' * SMPL_R_global * ( imu_acc' - root_acc' );
            input_imu_acc(ind,(1:3)+3*(j-1)) = norm_acc;
        end
        ind = ind + 1;
    end
    
    figure(1); clf; hold on;
    plot( input_imu_acc(:,13), 'r' );
    plot( input_imu_acc(:,14), 'g' );
    plot( input_imu_acc(:,15), 'b' );
    
    output_smpl_rot = zeros( (end_i-start_i)+1, 15*9 );
    
    ind = 1;
    for i=start_i:end_i
        % Joint Mapping - By Hand
        
        [smpl_rot, smpl_angles] = ConvertMVNtoSMPL( jointData(i,:) );
        output_smpl_rot( ind, : ) = reshape( smpl_rot(1:15,:)', 1, 135 );
        
        ind = ind+1;
    end
    
    figure(2); clf; hold on;
    plot( output_smpl_rot(:,1), 'r' )
    %plot( output_smpl_rot(:,2), 'g' )
    %plot( output_smpl_rot(:,3), 'b' )
    plot( output_smpl_rot(:,6), 'g' )
    plot( output_smpl_rot(:,8), 'b' )
    
%     root_dat = sensorData(1,1+(1:7)+7*(imu_root-1));
%     root_quat = root_dat(1:4);
%     root_acc = root_dat(5:7);
% 
%     root_rot = quat2rot(root_quat);
%     SMPL_R_global * root_rot
    %zxy = rot2zxy(rot)*180/pi;
    
%     csvwrite('input_imu_rot.csv', input_imu_rot);
%     csvwrite('input_imu_acc.csv', input_imu_acc);
%     csvwrite('output_smpl_rot.csv', output_smpl_rot);
end

function rot = quat2rot(quat)
    qi = quat(2);
    qj = quat(3);
    qk = quat(4);
    qr = quat(1);
    
    rot = zeros(3,3);
    
    rot(1,1) = 1 - 2*(qj^2 + qk^2);
    rot(2,2) = 1 - 2*(qi^2 + qk^2);
    rot(3,3) = 1 - 2*(qi^2 + qj^2);
    
    rot(1,2) = 2*(qi*qj-qk*qr);
    rot(2,1) = 2*(qi*qj+qk*qr);
    
    rot(1,3) = 2*(qi*qk+qj*qr);
    rot(3,1) = 2*(qi*qk-qj*qr);
    
    rot(2,3) = 2*(qj*qk-qi*qr);
    rot(3,2) = 2*(qj*qk+qi*qr);
end

function zxy = rot2zxy(rot)
    zxy = zeros(3,1);
    
    zxy(1) = atan2(-rot(2,3), sqrt( rot(2,1)^2 + rot(2,2)^2 ));
    zxy(2) = atan2( rot(1,3), rot(3,3) );
    zxy(3) = atan2( rot(2,1), rot(2,2) );
end

function rot = xyz2rot(xyz)
    x = xyz(1) * pi/180;
    xrot = [1,0,0; 0,cos(x),-sin(x); 0, sin(x),cos(x)];
    
    y = xyz(2) * pi/180;
    yrot = [cos(y),0,sin(y); 0,1,0; -sin(y),0,cos(y)];
    
    z = xyz(3) * pi/180;
    zrot = [cos(z),-sin(z),0; sin(z),cos(z),0; 0,0,1];
    
    rot = zrot * yrot * xrot;
end

function rot = zxy2rot(zxy)
    x = zxy(2) * pi/180;
    xrot = [1,0,0; 0,cos(x),-sin(x); 0, sin(x),cos(x)];
    
    y = zxy(3) * pi/180;
    yrot = [cos(y),0,sin(y); 0,1,0; -sin(y),0,cos(y)];
    
    z = zxy(1) * pi/180;
    zrot = [cos(z),-sin(z),0; sin(z),cos(z),0; 0,0,1];
    
    rot = yrot * xrot * zrot;
end

function rot = xzy2rot(zxy)
    x = zxy(2) * pi/180;
    xrot = [1,0,0; 0,cos(x),-sin(x); 0, sin(x),cos(x)];
    
    y = zxy(3) * pi/180;
    yrot = [cos(y),0,sin(y); 0,1,0; -sin(y),0,cos(y)];
    
    z = zxy(1) * pi/180;
    zrot = [cos(z),-sin(z),0; sin(z),cos(z),0; 0,0,1];
    
    rot = yrot * zrot * xrot;
end