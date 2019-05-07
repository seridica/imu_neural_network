%%%
% File: DataSetStats.m
% Author: Calvin Kuo
% Date: 03-19-2019
%
% Script for checking stats on the dataset

% Average Step Lengths
all_step_lengths = zeros( length( all_steps ), 1 );
for i=1:length( all_steps )
    all_step_lengths(i) = size( all_steps{i}, 1 );
end

max_step_length = max( all_step_lengths )
min_step_length = min( all_step_lengths )
ave_step_length = mean( all_step_lengths )
std_step_length = std( all_step_lengths )
