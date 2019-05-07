%%%
%
% File Name: XsensRotation.m
%
% Quick script for finding the sensor0 to global
% Then from global to SMPL is a right-rotation

SMPL_R_global = zeros(3,3);
SMPL_R_global(3,1) = 1; % Global x -> SMPL z
SMPL_R_global(1,2) = 1; % Global y -> SMPL x
SMPL_R_global(2,3) = 1; % GLobal z -> SMPL y

