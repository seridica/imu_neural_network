# -*- coding: utf-8 -*-
"""
Created on Tue Mar 26 19:28:03 2019

@author: Calvin
"""

import numpy as np
import os

# Get the statistics dictionary
npfz = np.load("D:/UBC - Postdoc/Sensors/Motion Reconstruction/MPI SMPL DIP/DIP_IMU_data/imu_own_validation.npz")
statistics = npfz['statistics'].item()

# This is where I keep the csv files for conversion on my computer
root_dir = "D:/UBC - Postdoc/Sensors/Motion Reconstruction/DIP Full Traces/";
subjects = ["Subject1", "Subject2", "Subject3", "Subject4", "Subject5"]
#subjects = ["Subject5"]

orientation = [];
acceleration = [];
smpl_pose = [];
data_id = [];
file_id = [];

# Cycle through subject folders
for i in range(len(subjects)):
    
    # Go to subject folder
    os.chdir( root_dir + subjects[i] )
    
    # Metedata
    file_id.append( root_dir + subjects[i] )
    data_id.append( subjects[i] )
    
    # Open IMU free accelerations and add
    f = open("input_imu_acc.csv", "rb")
    
    imu_acc_data = np.loadtxt(f, delimiter=',')
    acceleration.append( imu_acc_data )
    
    f.close();
    
    # Open IMU orientations and add
    f = open("input_imu_rot.csv", "rb")
    imu_rot_data = np.loadtxt(f,delimiter=',')
    orientation.append( imu_rot_data )
    
    f.close();
    
    # Open SMPL pose and add
    f = open("output_smpl_rot.csv", "rb")
    smpl_rot_data = np.loadtxt(f,delimiter=',')
    smpl_pose.append( smpl_rot_data )
    
    f.close()
            
os.chdir(root_dir)

# CHANGE THE FILENAME IF NECESSARY
np.savez("dip_data_s01.npz", file_id=file_id, data_id=data_id, statistics=statistics, orientation=orientation, smpl_pose=smpl_pose, acceleration=acceleration)
