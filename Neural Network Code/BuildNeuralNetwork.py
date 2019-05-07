# -*- coding: utf-8 -*-
"""
Created on Mon Apr  1 10:13:21 2019

@author: Calvin
"""

from keras.models import Sequential
from keras.layers import LSTM, Dense, TimeDistributed
from keras.utils import plot_model
import numpy as np
import matplotlib.pyplot as plt

simple_lstm_model = Sequential();
#simple_lstm_model.add(Dense(64, activation='relu', input_shape=(32,)))
simple_lstm_model.add(LSTM( units=64,
                            activation='tanh',
                            recurrent_activation='hard_sigmoid',
                            use_bias=True,
                            kernel_initializer='glorot_uniform',
                            recurrent_initializer='orthogonal',
                            bias_initializer='zeros',
                            unit_forget_bias=True,
                            kernel_regularizer=None,
                            recurrent_regularizer=None,
                            bias_regularizer=None,
                            activity_regularizer=None,
                            kernel_constraint=None,
                            recurrent_constraint=None,
                            bias_constraint=None,
                            dropout=0.0,
                            recurrent_dropout=0.0,
                            implementation=1,
                            return_sequences=True,
                            return_state=False,
                            go_backwards=False,
                            stateful=False,
                            unroll=False,
                            input_shape=(2000,12) ) )
#simple_lstm_model.add(Dense(18, activation='linear'))
simple_lstm_model.add(TimeDistributed(Dense(18)))

simple_lstm_model.compile(loss='mean_squared_error', optimizer='adam', metrics=['mean_absolute_error'])

plot_model(simple_lstm_model, to_file='model.png', show_shapes=True)

# Data preparation
load_data = np.load('D:/UBC - Postdoc/Sensors/Motion Reconstruction/Fixed Step Dataset/training_steps_top.npz')

# Standardize
imu_inputs = load_data['imu_inputs']
joint_outputs = load_data['joint_outputs']
data_stats = load_data['stats'].item()
for i in range( imu_inputs.shape[0] ):
    curr_input = imu_inputs[i,:,:]
    imu_inputs[i,:,:] = np.divide( np.subtract(curr_input, data_stats['input_mean']), data_stats['input_std'] )
    #np.add( np.divide( curr_input, data_stats['input_std'] ), data_stats['input_mean'] )
    
    curr_output = joint_outputs[i,:,:]
    joint_outputs[i,:,:] = np.divide( np.subtract(curr_output, data_stats['output_mean']), data_stats['output_std'])
    #np.add( np.divide( curr_output, data_stats['output_std'] ), data_stats['output_mean'])
    
# Unstandardized for comparison
imu_orig = load_data['imu_inputs']
joint_orig = load_data['joint_outputs']

# Randomly partition training and testing data
valid_split = 0.1
shuffle_inds = np.arange(imu_inputs.shape[0])
np.random.shuffle(shuffle_inds)
imu_shuffle = imu_inputs[shuffle_inds,:,:]
joint_shuffle = joint_outputs[shuffle_inds,:,:]

split_ind = int( np.ceil((1-valid_split) * imu_shuffle.shape[0]) )

train_imu = imu_shuffle[:split_ind,:,:]
valid_imu = imu_shuffle[split_ind:,:,:]

train_joint = joint_shuffle[:split_ind,:,:]
valid_joint = joint_shuffle[split_ind:,:,:]

# Train
history = simple_lstm_model.fit( train_imu, train_joint, epochs=10, batch_size=20, verbose=1, validation_data=(valid_imu, valid_joint))

# Plot training & validation accuracy values
plt.figure(1)
plt.clf()
plt.plot(history.history['mean_absolute_error'])
plt.plot(history.history['val_mean_absolute_error'])
plt.title('Model accuracy')
plt.ylabel('Accuracy')
plt.xlabel('Epoch')
plt.legend(['Train', 'Test'], loc='upper left')
plt.show()

# Plot training & validation loss values
plt.figure(2)
plt.clf()
plt.plot(history.history['loss'])
plt.plot(history.history['val_loss'])
plt.title('Model loss')
plt.ylabel('Loss')
plt.xlabel('Epoch')
plt.legend(['Train', 'Test'], loc='upper left')
plt.show()
