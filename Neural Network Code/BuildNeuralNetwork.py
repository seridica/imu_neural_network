# -*- coding: utf-8 -*-
"""
Created on Mon Apr  1 10:13:21 2019

@author: Calvin
"""

from keras.models import Sequential
from keras.layers import LSTM, GRU, Dense, TimeDistributed, Bidirectional
from keras.callbacks import History
from keras.utils import plot_model
import numpy as np
import matplotlib.pyplot as plt

from typing import NamedTuple

# Data definition for models with labels/names
NamedModel = NamedTuple('NamedModel', [('name',str),
                                        ('model',Sequential)])

# Data definition for trained models with labels/names and loss/metric history
TrainedModel = NamedTuple('TrainedModel', [('name',str),
                                            ('model',Sequential),
                                            ('history',History)])

# Define Models

# LSTM - 64 units

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

# GRU - 64 units

simple_gru_model = Sequential();
#simple_gru_model.add(Dense(64, activation='relu', input_shape=(32,)))
simple_gru_model.add(GRU( units=64,
                            activation='tanh',
                            recurrent_activation='hard_sigmoid',
                            use_bias=True,
                            kernel_initializer='glorot_uniform',
                            recurrent_initializer='orthogonal',
                            bias_initializer='zeros',
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
                            reset_after=False,
                            input_shape=(2000,12) ) )
#simple_gru_model.add(Dense(18, activation='linear'))
simple_gru_model.add(TimeDistributed(Dense(18)))

# Bidirectional LSTM - 64 units

bi_lstm_model = Sequential();
bi_lstm_model.add(Bidirectional(LSTM( units=64,
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
                            input_shape=(2000,12) ) ) )
#bi_lstm_model.add(Dense(18, activation='linear'))
bi_lstm_model.add(TimeDistributed(Dense(18)))

# Bi-GRU - 64 units

bi_gru_model = Sequential();
#simple_gru_model.add(Dense(64, activation='relu', input_shape=(32,)))
bi_gru_model.add(Bidirectional(GRU( units=64,
                            activation='tanh',
                            recurrent_activation='hard_sigmoid',
                            use_bias=True,
                            kernel_initializer='glorot_uniform',
                            recurrent_initializer='orthogonal',
                            bias_initializer='zeros',
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
                            reset_after=False,
                            input_shape=(2000,12) ) ) )
#bi_gru_model.add(Dense(18, activation='linear'))
bi_gru_model.add(TimeDistributed(Dense(18)))

named_models = [NamedModel('LSTM',simple_lstm_model),
            NamedModel('GRU',simple_gru_model),
            NamedModel('Bi-LSTM',bi_lstm_model),
            NamedModel('Bi-GRU',bi_gru_model)]

# Data Preparation

#load_data = np.load('D:/UBC - Postdoc/Sensors/Motion Reconstruction/Fixed Step Dataset/training_steps_top.npz')
load_data = np.load('/Users/mattdietrich/Downloads/RA/Motion Reconstruction/Neural Network Training Data/Fixed Step Dataset/training_Steps_top.npz')

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

# Training

trained_models = []
for named_model in named_models:
    print("\nTraining %s ..." % named_model.name)
    named_model.model.compile(loss='mean_squared_error', optimizer='adam', metrics=['mean_absolute_error'])
    plot_model(named_model.model, to_file='%s.png'%named_model.name, show_shapes=True)

    history = named_model.model.fit(train_imu, train_joint, epochs=10, batch_size=20, verbose=1, validation_data=(valid_imu, valid_joint))

    trained_model = TrainedModel(named_model.name, named_model.model, history)
    trained_models.append(trained_model)

    filename = '%s.h5' % named_model.name
    named_model.model.save(filename)
    print("Model saved as %s" % '%s.h5' % named_model.name)

# Plotting Metrics / Loss

# Plot training & validation error values
plt.figure(1)
plt.clf()
for trained_model in trained_models:
    history = trained_model.history
    plt.plot(history.history['mean_absolute_error'], label='%s - Train'%trained_model.name)
    plt.plot(history.history['val_mean_absolute_error'], label='%s - Test'%trained_model.name)
plt.title('Model Absolute Error')
plt.ylabel('Absolute Error')
plt.xlabel('Epoch')
plt.legend(bbox_to_anchor=(1.05, 1),loc='upper left')
plt.tight_layout()
plt.savefig('fig_absolute_error.png')
# plt.show()

# Plot training & validation loss values
plt.figure(2)
plt.clf()
for trained_model in trained_models:
    history = trained_model.history
    plt.plot(history.history['loss'], label='%s - Train'%trained_model.name)
    plt.plot(history.history['val_loss'], label='%s - Test'%trained_model.name)
plt.title('Model Loss (Squared Error)')
plt.ylabel('Squared Error')
plt.xlabel('Epoch')
plt.legend(bbox_to_anchor=(1.05, 1),loc='upper left')
plt.tight_layout()
plt.savefig('fig_loss.png')
# plt.show()
