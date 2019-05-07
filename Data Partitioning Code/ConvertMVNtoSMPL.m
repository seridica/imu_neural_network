    %%%
% File: ConvertMVNtoSMPL.m
% Author: Calvin Kuo
% Date: 04-10-2019
%
% Function for converting MVN joint angles to SMPL joint angles

function [SMPL_rotmat, SMPL_angles] = ConvertMVNtoSMPL( MVN_angles )

    % Joint Angle
    SMPL_R_ISB = zeros(3,3);
    SMPL_R_ISB(1,3) = -1;
    SMPL_R_ISB(2,2) = 1;
    SMPL_R_ISB(3,1) = 1;
    
    SMPL_rotmat = zeros( 17,9 );
    SMPL_angles = zeros( 17,3 );
    
    % Joint Mapping - By Hand

    %% Left Hip (Xsens ID 19)
    % MVN flexion/extension -> +Z (ISB) -> -X (SMPL)
    % MVN interal/external rotation -> -Y (ISB) -> -Y (SMPL)
    % MVN abduction/adduction -> +X (ISB) -> +Z (SMPL)

    lhip_mvn = MVN_angles(1+(1:3)+3*(19-1));
    lhip_zxy = [lhip_mvn(3), lhip_mvn(1), -lhip_mvn(2)];
    lhip_mvn_rot = zxy2rot( lhip_zxy );

    lhip_smpl = SMPL_R_ISB * lhip_mvn_rot * SMPL_R_ISB';
    %output_smpl_rot(ind,(1:3)) = lhip_zxy;
    SMPL_rotmat(1,:) = reshape( lhip_smpl', 1, 9 );
    SMPL_angles(1,:) = rot2xzy( lhip_smpl );

    %% Right Hip (Xsens ID 15)
    % MVN flexion/exteion -> +Z
    % MVN interal/external rotation -> +Y
    % MVN abduction/adduction -> -X

    rhip_mvn = MVN_angles(1+(1:3)+3*(15-1));
    rhip_zxy = [rhip_mvn(3), -rhip_mvn(1), rhip_mvn(2)];
    rhip_mvn_rot = zxy2rot( rhip_zxy );

    rhip_smpl = SMPL_R_ISB * rhip_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(2,:) = reshape( rhip_smpl', 1, 9 );
    SMPL_angles(2,:) = rot2xzy( rhip_smpl );

    %% Spine1 (Xsens ID 1)
    % MVN flexion/exteion -> -Z
    % MVN axial rotation -> +Y
    % MVN lateral bend right/left -> +X

    sp1_mvn = MVN_angles(1+(1:3)+3*(1-1));
    sp1_zxy = [-sp1_mvn(3), sp1_mvn(1), sp1_mvn(2)];
    sp1_mvn_rot = zxy2rot( sp1_zxy );

    sp1_smpl = SMPL_R_ISB * sp1_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(3,:) = reshape( sp1_smpl', 1, 9 );
    SMPL_angles(3,:) = rot2xzy( sp1_smpl );

    %% Left Knee (Xsens ID 20)
    % MVN flexion/exteion -> -Z
    % MVN internal/external rotation -> -Y
    % MVN abduction/adduction -> +X

    lknee_mvn = MVN_angles(1+(1:3)+3*(20-1));
    lknee_zxy = [-lknee_mvn(3), lknee_mvn(1), -lknee_mvn(2)];
    lknee_mvn_rot = zxy2rot( lknee_zxy );

    lknee_smpl = SMPL_R_ISB * lknee_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(4,:) = reshape( lknee_smpl', 1, 9 );
    SMPL_angles(4,:) = rot2xzy( lknee_smpl );

    %% Right Knee (Xsens ID 16)
    % MVN flexion/exteion -> -Z
    % MVN internal/external rotation -> +Y
    % MVN abduction/adduction -> -X

    rknee_mvn = MVN_angles(1+(1:3)+3*(16-1));
    rknee_zxy = [-rknee_mvn(3), -rknee_mvn(1), rknee_mvn(2)];
    rknee_mvn_rot = zxy2rot( rknee_zxy );

    rknee_smpl = SMPL_R_ISB * rknee_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(5,:) = reshape( rknee_smpl', 1, 9 );
    SMPL_angles(5,:) = rot2xzy( rknee_smpl );

    %% Spine2 (Xsens ID 2 + 3)
    % MVN flexion/exteion -> -Z
    % MVN axial rotation -> +Y
    % MVN lateral bend right/left -> +X

    sp2_mvn = MVN_angles(1+(1:3)+3*(2-1));
    sp2_zxy = [-sp2_mvn(3), sp2_mvn(1), sp2_mvn(2)];
    sp2_mvn_rot = zxy2rot( sp2_zxy );

    sp2b_mvn = MVN_angles(1+(1:3)+3*(3-1));
    sp2b_zxy = [-sp2b_mvn(3), sp2b_mvn(1), sp2b_mvn(2)];
    sp2b_mvn_rot = zxy2rot( sp2b_zxy );

    sp2_smpl = SMPL_R_ISB * sp2b_mvn_rot * sp2_mvn_rot * SMPL_R_ISB';

    SMPL_rotmat(6,:) = reshape( sp2_smpl', 1, 9 );
    SMPL_angles(6,:) = rot2xzy( sp2_smpl );

    %% Spine3 (Xsens ID 4)
    % MVN flexion/exteion -> -Z
    % MVN axial rotation -> +Y
    % MVN lateral bend right/left -> +X

    sp3_mvn = MVN_angles(1+(1:3)+3*(4-1));
    sp3_zxy = [-sp3_mvn(3), sp3_mvn(1), sp3_mvn(2)];
    sp3_mvn_rot = zxy2rot( sp3_zxy );

    sp3_smpl = SMPL_R_ISB * sp3_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(7,:) = reshape( sp3_smpl', 1, 9 );
    SMPL_angles(7,:) = rot2xzy( sp3_smpl );

    %% Neck (Xsens ID 5)
    % MVN flexion/exteion -> -Z
    % MVN axial rotation -> +Y
    % MVN lateral bend right/left -> +X

    neck_mvn = MVN_angles(1+(1:3)+3*(5-1));
    neck_zxy = [-neck_mvn(3), neck_mvn(1), neck_mvn(2)];
    neck_mvn_rot = zxy2rot( neck_zxy );

    neck_smpl = SMPL_R_ISB * neck_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(8,:) = reshape( neck_smpl', 1, 9 );
    SMPL_angles(8,:) = rot2xzy( neck_smpl );

    %% Left Collar (Xsens ID 11)
    % MVN flexion/extension -> +Z
    % MVN internal/external rotation -> -Y
    % MVN abduction/adduction -> +X -20 deg (T-pose for SMPL zero)

    lcoll_mvn = MVN_angles(1+(1:3)+3*(11-1));
    lcoll_zxy = [lcoll_mvn(3), lcoll_mvn(1)-20, -lcoll_mvn(2)];
    lcoll_mvn_rot = zxy2rot( lcoll_zxy );

    lcoll_smpl = SMPL_R_ISB * lcoll_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(9,:) = reshape( lcoll_smpl', 1, 9 );
    SMPL_angles(9,:) = rot2xzy( lcoll_smpl );

    %% Right Collar (Xsens ID 7)
    % MVN flexion/extension -> +Z
    % MVN internal/external rotation -> +Y
    % MVN abduction/adduction -> -X -20 deg (T-pose for SMPL zero)

    rcoll_mvn = MVN_angles(1+(1:3)+3*(7-1));
    rcoll_zxy = [rcoll_mvn(3), -rcoll_mvn(1)+20, rcoll_mvn(2)];
    rcoll_mvn_rot = zxy2rot( rcoll_zxy );

    rcoll_smpl = SMPL_R_ISB * rcoll_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(10,:) = reshape( rcoll_smpl', 1, 9 );
    SMPL_angles(10,:) = rot2xzy( rcoll_smpl );

    %% Head (Xsens ID 6)
    % MVN flexion/exteion -> -Z
    % MVN axial rotation -> +Y
    % MVN lateral bend right/left -> +X

    head_mvn = MVN_angles(1+(1:3)+3*(6-1));
    head_zxy = [-head_mvn(3), head_mvn(1), head_mvn(2)];
    head_mvn_rot = zxy2rot( head_zxy );

    head_smpl = SMPL_R_ISB * head_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(11,:) = reshape( head_smpl', 1, 9 );
    SMPL_angles(11,:) = rot2xzy( head_smpl );

    %% Left Shoulder (Xsens ID 12)
    % MVN flexion/extension -> +Z
    % MVN internal/external rotation -> -Y
    % MVN abduction/adduction -> +X -70 deg (T-pose for SMPL zero)

    lshou_mvn = MVN_angles(1+(1:3)+3*(12-1));
    lshou_zxy = [lshou_mvn(3), lshou_mvn(1)-70, -lshou_mvn(2)];
    lshou_mvn_rot = zxy2rot( lshou_zxy );

    lshou_smpl = SMPL_R_ISB * lshou_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(12,:) = reshape( lshou_smpl', 1, 9 );
    SMPL_angles(12,:) = rot2xzy( lshou_smpl );

    %% Right Shoulder (Xsens ID 8)
    % MVN flexion/extension -> +Z
    % MVN internal/external rotation -> +Y
    % MVN abduction/adduction -> -X -70 deg (T-pose for SMPL zero)

    rshou_mvn = MVN_angles(1+(1:3)+3*(8-1));
    rshou_zxy = [rshou_mvn(3), -rshou_mvn(1)+70, rshou_mvn(2)];
    rshou_mvn_rot = zxy2rot( rshou_zxy );

    rshou_smpl = SMPL_R_ISB * rshou_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(13,:) = reshape( rshou_smpl', 1, 9 );
    SMPL_angles(13,:) = rot2xzy( rshou_smpl );

%         %% Left Elbow (Xsens ID 13)
%         % MVN flexion/extension -> -Z
%         % MVN pronation/supination -> +Y
%         % MVN radial deviation/ulnar deviation -> +X
%         
%         lelb_mvn = jointData(i, 1+(1:3)+3*(13-1));
%         lelb_zxy = [lelb_mvn(3), lelb_mvn(1), -(lelb_mvn(2) - 90)];
%         lelb_mvn_rot = zxy2rot( lelb_zxy );
%         
%         lelb_smpl = SMPL_R_global * lelb_mvn_rot * SMPL_R_global';
%         output_smpl_rot(ind,(1:9)+9*13) = reshape( lelb_smpl', 1, 9 );
%         
%         %% Right Elbow (Xsens ID 9)
%         % MVN flexion/extension -> +Z
%         % MVN pronation/supination -> +Y
%         % MVN radial deviation/ulnar deviation -> -X
%         
%         relb_mvn = jointData(i, 1+(1:3)+3*(9-1));
%         relb_zxy = [relb_mvn(3), -relb_mvn(1), (relb_mvn(2) - 90)];
%         relb_mvn_rot = zxy2rot( relb_zxy );
%         
%         relb_smpl = SMPL_R_global * relb_mvn_rot * SMPL_R_global';
%         output_smpl_rot(ind,(1:9)+9*14) = reshape( relb_smpl', 1, 9 );

    %% Left Elbow (Xsens ID 13)
    % MVN flexion/extension -> +X
    % MVN pronation/supination -> -Z
    % MVN radial deviation/ulnar deviation -> +Y

    lelb_mvn = MVN_angles(1+(1:3)+3*(13-1));
    lelb_zxy = [-(lelb_mvn(2) - 90), lelb_mvn(3), lelb_mvn(1)];
    lelb_mvn_rot = zxy2rot( lelb_zxy );

    lelb_smpl = SMPL_R_ISB * lelb_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(14,:) = reshape( lelb_smpl', 1, 9 );
    SMPL_angles(14,:) = rot2xzy( lelb_smpl );

    %% Right Elbow (Xsens ID 9)
    % MVN flexion/extension -> -X
    % MVN pronation/supination -> -Z
    % MVN radial deviation/ulnar deviation -> -Y

    relb_mvn = MVN_angles(1+(1:3)+3*(9-1));
    relb_zxy = [-(relb_mvn(2) - 90), -relb_mvn(3), -relb_mvn(1)];
    relb_mvn_rot = zxy2rot( relb_zxy );

    relb_smpl = SMPL_R_ISB * relb_mvn_rot * SMPL_R_ISB';
    SMPL_rotmat(15,:) = reshape( relb_smpl', 1, 9 );
    SMPL_angles(15,:) = rot2xzy( relb_smpl );
    
    %% EXTRA ANKLE JOINT ANGLES FOR OUR LSTM
    %% Left Foot (Xsens ID 22)
    % MVN dorsiflexion/plantarflexion -> +Z (ISB) -> -X (SMPL)
    % MVN interal/external rotation -> -Y (ISB) -> -Y (SMPL)
    % MVN abduction/adduction -> +X (ISB) -> +Z (SMPL)

    lfoot_mvn = MVN_angles(1+(1:3)+3*(19-1));
    lfoot_zxy = [lfoot_mvn(3), lfoot_mvn(1), -lfoot_mvn(2)];
    lfoot_mvn_rot = zxy2rot( lhip_zxy );

    lfoot_smpl = SMPL_R_ISB * lfoot_mvn_rot * SMPL_R_ISB';
    %output_smpl_rot(ind,(1:3)) = lhip_zxy;
    SMPL_rotmat(16,:) = reshape( lfoot_smpl', 1, 9 );
    SMPL_angles(16,:) = rot2xzy( lfoot_smpl );
    
    %% Right Foot (Xsens ID 18)
    % MVN dorsiflexion/plantarflexion -> +Z (ISB) -> -X (SMPL)
    % MVN interal/external rotation -> +Y (ISB) -> -Y (SMPL)
    % MVN abduction/adduction -> -X (ISB) -> -Z (SMPL)
    
    rfoot_mvn = MVN_angles(1+(1:3)+3*(19-1));
    rfoot_zxy = [rfoot_mvn(3), -rfoot_mvn(1), rfoot_mvn(2)];
    rfoot_mvn_rot = zxy2rot( rfoot_zxy );

    rfoot_smpl = SMPL_R_ISB * rfoot_mvn_rot * SMPL_R_ISB';
    %output_smpl_rot(ind,(1:3)) = lhip_zxy;
    SMPL_rotmat(17,:) = reshape( rfoot_smpl', 1, 9 );
    SMPL_angles(17,:) = rot2xzy( rfoot_smpl );
    
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

function xzy = rot2xzy( rot )
    xzy = zeros(3,1);
    
    xzy(1) = atan2( rot(2,1), sqrt( rot(1,1)^2 + rot(3,1)^2 ));
    xzy(2) = atan2( -rot(2,3), rot(2,2) );
    xzy(3) = atan2( -rot(3,1), rot(1,1) );
end