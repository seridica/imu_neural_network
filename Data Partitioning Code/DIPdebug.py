# -*- coding: utf-8 -*-
"""
Created on Fri Mar 29 09:49:45 2019

@author: Calvin
"""

import numpy as np

npout = np.load('D:/UBC - Postdoc/Sensors/Motion Reconstruction/DIP Full Traces/dip_data_calvin_full_all_frames.npz')

indices = np.r_[9:18,18:27,27:36,36:45,45:54,54:63,81:90,108:117,117:126,126:135,135:144,144:153,153:162,162:171,171:180]

inputs = npout['gt'][0][:,indices]
outputs = npout['prediction'][0][:,indices]