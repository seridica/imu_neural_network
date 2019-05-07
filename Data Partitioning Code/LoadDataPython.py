# -*- coding: utf-8 -*-
"""
Created on Thu Mar 21 14:37:28 2019

@author: Calvin
"""

import numpy as np
import os

# Method if training data are of different lengths
if 0:
    # This is where I keep the csv files for conversion on my computer
    os.chdir("D:/UBC - Postdoc/Sensors/Motion Reconstruction/Temp Dataset Folder")
    
    # Go through files in the conversion directory
    imu_inputs = []
    joint_outputs = []
    
    imu_stats = np.array(());
    joint_stats = np.array(());
    
    imu_stats.shape = (0,12)
    joint_stats.shape = (0,18)
    
    for root, dirs, files in os.walk("."):
        for file in files:
            if file.endswith(".csv"):
                f = open(file, "rb")
                step_data = np.loadtxt(f,delimiter=',')
                
                imu_inputs.append( step_data[:,1:13] )
                imu_stats = np.append( imu_stats, step_data[:,1:13], 0 )
                
                joint_outputs.append( step_data[:,13:31] )
                joint_stats = np.append( joint_stats, step_data[:,13:31], 0 )
                
                #data.append( step_data )
                f.close()
    
    # CHANGE THE FILENAME IF NECESSARY
    stats = {'input_mean': np.mean( imu_stats, 0 ),
             'input_std': np.std( imu_stats, 0 ),
             'output_mean': np.mean( joint_stats, 0 ),
             'output_std': np.std( joint_stats, 0 )}
    np.savez("training_steps.npz", imu_inputs=imu_inputs, joint_outputs=joint_outputs, stats=stats)

else:
    # This is where I keep the csv files for conversion on my computer
    os.chdir("D:/UBC - Postdoc/Sensors/Motion Reconstruction/Temp Dataset Folder")
    
    # Go through files in the conversion directory
    imu_inputs = []
    joint_outputs = []
    
    imu_stats = np.array(());
    joint_stats = np.array(());
    
    imu_stats.shape = (0,12)
    joint_stats.shape = (0,18)
    
    for root, dirs, files in os.walk("."):
        for file in files:
            if file.endswith(".csv"):
                f = open(file, "rb")
                step_data = np.loadtxt(f,delimiter=',')
                
                imu_inputs.append( step_data[:,1:13] )
                imu_stats = np.append( imu_stats, step_data[:,1:13], 0 )
                
                joint_outputs.append( step_data[:,13:31] )
                joint_stats = np.append( joint_stats, step_data[:,13:31], 0 )
                
                #data.append( step_data )
                f.close()
    
    # CHANGE THE FILENAME IF NECESSARY
    stats = {'input_mean': np.mean( imu_stats, 0 ),
             'input_std': np.std( imu_stats, 0 ),
             'output_mean': np.mean( joint_stats, 0 ),
             'output_std': np.std( joint_stats, 0 )}
    np.savez("training_steps.npz", imu_inputs=imu_inputs, joint_outputs=joint_outputs, stats=stats)