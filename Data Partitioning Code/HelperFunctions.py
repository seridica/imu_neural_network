# -*- coding: utf-8 -*-
"""
Created on Thu Mar 21 16:29:34 2019

@author: Calvin
"""

import numpy as np

def Rodriguez(angle_axis):
    theta = np.linalg.norm(angle_axis)
    norm_vec = angle_axis / theta
    
    K = np.zeros((3,3))
    K[0][1] = -norm_vec[2]
    K[0][2] = norm_vec[1]
    K[1][0] = norm_vec[2]
    K[1][2] = -norm_vec[0]
    K[2][0] = -norm_vec[1]
    K[2][1] = norm_vec[0]
    
    R = np.eye(3) + np.sin(theta)*K + (1-np.cos(theta))*np.dot(K,K)
    
    return R

def EulerZYX(euler_angles):
    eulerz = euler_angles[0]
    eulery = euler_angles[1]
    eulerx = euler_angles[2]
    
    Rz = np.array([[np.cos(eulerz), -np.sin(eulerz), 0],
                   [np.sin(eulerz), np.cos(eulerz), 0],
                   [0, 0, 1]])
    
    Ry = np.array([[np.cos(eulery), 0, np.sin(eulery)],
                   [0, 1, 0],
                   [-np.sin(eulery), 0, np.cos(eulery)]])
    
    Rx = np.array([[1, 0, 0],
                   [0, np.cos(eulerx), -np.sin(eulerx)],
                   [0, np.sin(eulerx), np.cos(eulerx)]])
    
    R = np.dot( Rz, np.dot(Ry, Rx))
    
    return R