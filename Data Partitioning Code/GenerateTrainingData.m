%%%
% File: GenerateTrainingData.m
% Author: Calvin Kuo
% Date: 03-11-2019
%
% Script for generating training data. Once training data is created, do
% not replace.

%% Training Data Type Select
type_sel = 4;
top_of_feet = 2;

%% Joints to use for Xsens
joint_nums = [15,16,17,19,20,21]; % Lower body + pelvis
% joint_nums = [1,16,17,18,20,21,22]; % Lower body + pelvis - toes

joint_slice = zeros( 1, 1+length( joint_nums )*3 );
joint_slice(1) = 1;
for i=1:length( joint_nums )
    joint_slice( (1+(i-1)*3+1):(1+i*3) ) = [2:4]+(joint_nums(i)-1)*3;
end

%% Use Subjects: [] as training


%% Subject 1 data load
load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject01\Subject01_12142018\mvn_joint_data.mat')
load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject01\Subject01_12142018\xalign_dat.mat')

% Running Segment
if top_of_feet == 1
    % Top of feet
    sub1_steps = PartitionSteps( [xalign10_dat, xalign11_dat], jointData, 450, 710, type_sel, 5 );
else
    % Heels
    sub1_steps = PartitionSteps( [xalign02_dat, xalign12_dat], jointData, 450, 710, type_sel, 5 );
end

%% Subject 2 data load
load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject02\Subject02_12192018\xalign_dat.mat')
load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject02\Subject02_12192018\mvn_joint_dat.mat')

% Running Segment
if top_of_feet == 1
    % Top of feet
    sub2_steps = PartitionSteps( [xalign10_dat, xalign11_dat], jointData, 220, 380, type_sel, 5 );
else
    % Heels
    sub2_steps = PartitionSteps( [xalign02_dat, xalign12_dat], jointData, 220, 380, type_sel, 5 );
end

%% Subject 3 data Load
load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject03\Subject03_12172018\xalign_dat.mat')
load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject03\Subject03_12172018\mvn_joint_dat.mat')

% Running Segment
if top_of_feet == 1
    % Top of feet
    sub3_steps = PartitionSteps( [xalign10_dat, xalign11_dat], jointData, 455, 500, type_sel, 5 );
else
    % Heels
    sub3_steps = PartitionSteps( [xalign02_dat, xalign12_dat], jointData, 455, 500, type_sel, 5 );
end

%% Subject 4 data Load
% load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject04\Subject04_12192018\xalign_dat.mat')
% load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject04\Subject04_12192018\mvn_joint_dat.mat')
% 
% % Running Segment
% if top_of_feet == 1
%     % Top of feet
%     sub4_steps = PartitionSteps( [xalign10_dat, xalign11_dat], jointData, 460, 580, type_sel, 5 );
% else
%     % Heels
%     sub4_steps = PartitionSteps( [xalign02_dat, xalign12_dat], jointData, 460, 580, type_sel, 5 );
% end

%% Subject 5 data Load
load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject05\Subject05_12202018\xalign_dat.mat')
load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject05\Subject05_12202018\mvn_joint_dat.mat')

% Running Segment
if top_of_feet == 1
    % Top of feet
    sub5_steps = PartitionSteps( [xalign10_dat, xalign11_dat], jointData, 473, 650, type_sel, 5 );
else
    % Heels
    sub5_steps = PartitionSteps( [xalign02_dat, xalign12_dat], jointData, 473, 650, type_sel, 5 );
end

%% Subject 6 data Load
% load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject06\Subject06_02262019\mvn_joint_dat.mat')
% load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject06\Subject06_02262019\xalign_dat.mat')
% 
% % Running Segment
% if top_of_feet == 1
%     % Top of feet
%     sub6_steps = PartitionSteps( [xalign10_dat, xalign11_dat], jointData, 370, 650, type_sel, 5 );
% else
%     % Heels
%     sub6_steps = PartitionSteps( [xalign02_dat, xalign12_dat], jointData, 370, 650, type_sel, 5 );
% end

%% Subject 7 data Load
load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject07\Subject07_03062019\xalign_dat.mat')
load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject07\Subject07_03062019\mvn_joint_data.mat')

% Running Segment
if top_of_feet == 1
    % Top of feet
    sub7_steps = PartitionSteps( [xalign10_dat, xalign11_dat], jointData, 200, 290, type_sel, 5 );
else
    % Heels
    sub7_steps = PartitionSteps( [xalign02_dat, xalign12_dat], jointData, 200, 290, type_sel, 5 );
end

%% Subject 8 data Load
load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject08\Subject08_03142019\xalign_dat.mat')
load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject08\Subject08_03142019\mvn_joint_data.mat')

% Running Segment
if top_of_feet == 1
    % Top of feet
    sub8_steps = PartitionSteps( [xalign10_dat, xalign11_dat], jointData, 695, 850, type_sel, 5 );
else
    % Heels
    sub8_steps = PartitionSteps( [xalign02_dat, xalign12_dat], jointData, 695, 850, type_sel, 5 );
end

%% Check
all_steps = [sub1_steps, sub2_steps, sub3_steps, sub5_steps, sub7_steps, sub8_steps]; %, sub6_steps];