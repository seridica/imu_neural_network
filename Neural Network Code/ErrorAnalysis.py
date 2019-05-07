# -*- coding: utf-8 -*-
"""
Created on Mon May  6 09:46:31 2019

@author: Calvin
"""

import numpy as np
import matplotlib.pyplot as plt

def PlotJoints( nn_model, imu_inputs, joint_gt, stats ):
    joint_preds = PredictJoints( nn_model, imu_inputs, stats )
    plt.figure(1)
    plt.clf()
    
    # Sizing
    nSamples = joint_gt.shape[0]
    nT = joint_gt.shape[1]
    
    # Hips
    plt.subplot(3,2,1)
    plt.plot(joint_gt[:,:,0].reshape(nSamples*nT,1), color='red', label='gt hip x', linewidth=2)
    plt.plot(joint_gt[:,:,1].reshape(nSamples*nT,1), color='green', label='gt hip y', linewidth=2)
    plt.plot(joint_gt[:,:,2].reshape(nSamples*nT,1), color='blue', label='gt hip z', linewidth=2)
    plt.plot(joint_preds[:,:,0].reshape(nSamples*nT,1), color=(0.3, 0, 0), label='pred hip z', linewidth=2, linestyle='--')
    plt.plot(joint_preds[:,:,1].reshape(nSamples*nT,1), color=(0, 0.3, 0), label='pred hip z', linewidth=2, linestyle='--')
    plt.plot(joint_preds[:,:,2].reshape(nSamples*nT,1), color=(0, 0, 0.3), label='pred hip z', linewidth=2, linestyle='--')
    plt.title('Left Hip')
    plt.xlabel('Sample')
    plt.ylabel('Hip Angle (rad)')
    plt.show()
    
    plt.subplot(3,2,4)
    plt.plot(joint_gt[:,:,3].reshape(nSamples*nT,1), color='red', label='gt hip x', linewidth=2)
    plt.plot(joint_gt[:,:,4].reshape(nSamples*nT,1), color='green', label='gt hip y', linewidth=2)
    plt.plot(joint_gt[:,:,5].reshape(nSamples*nT,1), color='blue', label='gt hip z', linewidth=2)
    plt.plot(joint_preds[:,:,3].reshape(nSamples*nT,1), color=(0.3, 0, 0), label='pred hip z', linewidth=2, linestyle='--')
    plt.plot(joint_preds[:,:,4].reshape(nSamples*nT,1), color=(0, 0.3, 0), label='pred hip z', linewidth=2, linestyle='--')
    plt.plot(joint_preds[:,:,5].reshape(nSamples*nT,1), color=(0, 0, 0.3), label='pred hip z', linewidth=2, linestyle='--')
    plt.title('Right Hip')
    plt.xlabel('Sample')
    plt.ylabel('Hip Angle (rad)')
    plt.show()
    
    # Knees
    plt.subplot(3,2,2)
    plt.plot(joint_gt[:,:,6].reshape(nSamples*nT,1), color='red', label='gt hip x', linewidth=2)
    plt.plot(joint_gt[:,:,7].reshape(nSamples*nT,1), color='green', label='gt hip y', linewidth=2)
    plt.plot(joint_gt[:,:,8].reshape(nSamples*nT,1), color='blue', label='gt hip z', linewidth=2)
    plt.plot(joint_preds[:,:,6].reshape(nSamples*nT,1), color=(0.3, 0, 0), label='pred hip z', linewidth=2, linestyle='--')
    plt.plot(joint_preds[:,:,7].reshape(nSamples*nT,1), color=(0, 0.3, 0), label='pred hip z', linewidth=2, linestyle='--')
    plt.plot(joint_preds[:,:,8].reshape(nSamples*nT,1), color=(0, 0, 0.3), label='pred hip z', linewidth=2, linestyle='--')
    plt.title('Left Knee')
    plt.xlabel('Sample')
    plt.ylabel('Knee Angle (rad)')
    plt.show()
    
    plt.subplot(3,2,5)
    plt.plot(joint_gt[:,:,9].reshape(nSamples*nT,1), color='red', label='gt hip x', linewidth=2)
    plt.plot(joint_gt[:,:,10].reshape(nSamples*nT,1), color='green', label='gt hip y', linewidth=2)
    plt.plot(joint_gt[:,:,11].reshape(nSamples*nT,1), color='blue', label='gt hip z', linewidth=2)
    plt.plot(joint_preds[:,:,9].reshape(nSamples*nT,1), color=(0.3, 0, 0), label='pred hip z', linewidth=2, linestyle='--')
    plt.plot(joint_preds[:,:,10].reshape(nSamples*nT,1), color=(0, 0.3, 0), label='pred hip z', linewidth=2, linestyle='--')
    plt.plot(joint_preds[:,:,11].reshape(nSamples*nT,1), color=(0, 0, 0.3), label='pred hip z', linewidth=2, linestyle='--')
    plt.title('Right Knee')
    plt.xlabel('Sample')
    plt.ylabel('Knee Angle (rad)')
    plt.show()
    
    # Ankles
    plt.subplot(3,2,3)
    plt.plot(joint_gt[:,:,12].reshape(nSamples*nT,1), color='red', label='gt hip x', linewidth=2)
    plt.plot(joint_gt[:,:,13].reshape(nSamples*nT,1), color='green', label='gt hip y', linewidth=2)
    plt.plot(joint_gt[:,:,14].reshape(nSamples*nT,1), color='blue', label='gt hip z', linewidth=2)
    plt.plot(joint_preds[:,:,12].reshape(nSamples*nT,1), color=(0.3, 0, 0), label='pred hip z', linewidth=2, linestyle='--')
    plt.plot(joint_preds[:,:,13].reshape(nSamples*nT,1), color=(0, 0.3, 0), label='pred hip z', linewidth=2, linestyle='--')
    plt.plot(joint_preds[:,:,14].reshape(nSamples*nT,1), color=(0, 0, 0.3), label='pred hip z', linewidth=2, linestyle='--')
    plt.title('Left Ankle')
    plt.xlabel('Sample')
    plt.ylabel('Ankle Angle (rad)')
    plt.show()
    
    plt.subplot(3,2,6)
    plt.plot(joint_gt[:,:,15].reshape(nSamples*nT,1), color='red', label='gt hip x', linewidth=2)
    plt.plot(joint_gt[:,:,16].reshape(nSamples*nT,1), color='green', label='gt hip y', linewidth=2)
    plt.plot(joint_gt[:,:,17].reshape(nSamples*nT,1), color='blue', label='gt hip z', linewidth=2)
    plt.plot(joint_preds[:,:,15].reshape(nSamples*nT,1), color=(0.3, 0, 0), label='pred hip z', linewidth=2, linestyle='--')
    plt.plot(joint_preds[:,:,16].reshape(nSamples*nT,1), color=(0, 0.3, 0), label='pred hip z', linewidth=2, linestyle='--')
    plt.plot(joint_preds[:,:,17].reshape(nSamples*nT,1), color=(0, 0, 0.3), label='pred hip z', linewidth=2, linestyle='--')
    plt.title('Right Ankle')
    plt.xlabel('Sample')
    plt.ylabel('Ankle Angle (rad)')
    plt.show()

def JointMeanSquareError( nn_model, imu_inputs, joint_gt, stats ):
    joint_preds= PredictJoints( nn_model, imu_inputs, stats )
    
    joint_mse = np.sum( np.square( joint_preds - joint_gt ) ) / (np.prod(joint_gt.shape))
    
    return joint_mse

def JointMeanAbsError( nn_model, imu_inputs, joint_gt, stats ):
    joint_preds= PredictJoints( nn_model, imu_inputs, stats )
    
    joint_mse = np.sum( np.abs( joint_preds - joint_gt ) ) / (np.prod(joint_gt.shape))
    
    return joint_mse

def PredictJoints( nn_model, imu_inputs, stats ):
    ## Predict back on the test data
    joint_preds = nn_model.predict( imu_inputs )

    # Unstandardize
    for i in range( imu_inputs.shape[0] ):
        joint_preds[i,:,:] = np.add( np.multiply( joint_preds[i,:,:], stats['output_std'] ), stats['output_mean'] )
    
    return joint_preds