# -*- coding: utf-8 -*-
"""
Created on Mon Mar 25 14:46:07 2019

@author: Calvin
"""

## Script for visualizing DIP-IMU data
import numpy as np
import matplotlib.pyplot as plt
import math

npfz = np.load("D:/UBC - Postdoc/Sensors/Motion Reconstruction/MPI SMPL DIP/DIP_IMU_data/imu_own_test.npz")
smpl = npfz['smpl_pose']
imuo = npfz['orientation']

event = 1;

imu_size = imuo[event].shape
smpl_size = smpl[event].shape

nimu = int( imu_size[1] / 9 );
nsmpl = int( smpl_size[1] / 9 );

ndat = imu_size[0]
assert( ndat == smpl_size[0] )

imu_xyz = np.zeros((ndat,3))
smpl_xyz = np.zeros((ndat,3))
for i in range(ndat):
    #for j in range(nimu):
    j = 1
    imu_slice = imuo[event][i][(j*9):((j+1)*9)]
    imu_rot = np.zeros((3,3))
    imu_rot[0][0:3] = imu_slice[0:3]
    imu_rot[1][0:3] = imu_slice[3:6]
    imu_rot[2][0:3] = imu_slice[6:9]
    
    yimu = math.atan2(imu_rot[0][2], np.sqrt( imu_rot[1][2]*imu_rot[1][2] + imu_rot[2][2]*imu_rot[2][2] ))
    ximu = math.atan2(imu_rot[1][2] / -np.cos(yimu), imu_rot[2][2] / np.cos(yimu))
    zimu = math.atan2(imu_rot[0][1] / -np.cos(yimu), imu_rot[0][0] / np.cos(yimu))
    
    imu_xyz[i,0] = ximu * 180/np.pi
    imu_xyz[i,1] = yimu * 180/np.pi
    imu_xyz[i,2] = zimu * 180/np.pi
    
    j = 13
    smpl_slice = smpl[event][i][(j*9):((j+1)*9)]
    smpl_rot = np.zeros((3,3))
    smpl_rot[0][0:3] = smpl_slice[0:3]
    smpl_rot[1][0:3] = smpl_slice[3:6]
    smpl_rot[2][0:3] = smpl_slice[6:9]
    
    ysmpl = math.atan2(smpl_rot[0][2], np.sqrt( smpl_rot[1][2]*smpl_rot[1][2] + smpl_rot[2][2]*smpl_rot[2][2] ))
    xsmpl = math.atan2(smpl_rot[1][2] / -np.cos(ysmpl), smpl_rot[2][2] / np.cos(ysmpl))
    zsmpl = math.atan2(smpl_rot[0][1] / -np.cos(ysmpl), smpl_rot[0][0] / np.cos(ysmpl))
    
    smpl_xyz[i,0] = xsmpl * 180/np.pi
    smpl_xyz[i,1] = ysmpl * 180/np.pi
    smpl_xyz[i,2] = zsmpl * 180/np.pi
    
#fig = plt.figure()
n = np.arange(0,ndat);
plt.figure(1)
plt.plot(n, smpl_xyz[:,0], 'r', n, smpl_xyz[:,1], 'g', n, smpl_xyz[:,2], 'b')

plt.figure(2)
plt.plot(n, imu_xyz[:,0], 'r', n, imu_xyz[:,1], 'g', n, imu_xyz[:,2], 'b')
