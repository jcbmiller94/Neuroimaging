import numpy as np
import pandas as pd
import scipy.io as io
import json
from copy import deepcopy

# read in text file
x = np.genfromtxt('JSpilot1_resultsTXT.txt', names = True, dtype = None)

y = np.zeros((168,5))

y[:,0] = x['raw_start_time']
y[:,2] = x['raw_probe_time']
y[:,3] = x['cbRun']
y[:,4] = x['cbTrialType']
#print(y[167])

dictionary = {'1': np.zeros((24,5)), '2': np.zeros((24,5)), '3': np.zeros((24,5)),'4': np.zeros((24,5)), '5': np.zeros((24,5)), '6': np.zeros((24.5)), '7': np.zeros((24.5))}

for i in range(len(dictionary)):
	dictionary[str(i+1)] = y[(i*24):((i+1)*24)]
	##print(dictionary[str(i+1)])

#looping through the dictionary (1 entry for each run) to correct for start times of each run
for i in range(len(dictionary)):
	arr = dictionary[str(i+1)]
	a = arr[0,0]
	b = arr[0,2]
	for k in range(arr.shape[0]):
		arr[k,0] -= a #setting first time of each run to zero, all other times in this run relative to this point
		arr[k,1] = arr[k,0] + 4.0
		arr[k,2] -= a
		arr[k,0:3] += + 442*i + 10.7 #adjusting times for the start of each run (221 TRs = 442 s)
		arr[k,2] -= 0.2
	#print(arr)

y2 = np.empty((0,5))

for i in range(len(dictionary)):
	y2 = np.append(y2, dictionary[str(i+1)], axis = 0)

np.savetxt('Onsets_Collapsed.txt', y2)

"""splitting up the onset times by trial types - using a pandas data frame to do so. Sorting by 
trial type and then by E, encoding onset time"""

trial_types = {'1': np.empty((0,3)), '2': np.empty((0,3)), '3': np.empty((0,3)),'4': np.empty((0,3)), '5': np.empty((0,3))}

df = pd.DataFrame(y2, columns = ['E','D','P','Run','TT'])
#Encoding, delay, probe, run number, trial type
df = df.sort_values(['TT','E'])
#np.savetxt('Onsets_Concatenated.txt', df)

TT1 = np.array(df.iloc[0:28,0:5])
TT2 = np.array(df.iloc[28:56,0:5])
TT3 = np.array(df.iloc[56:112,0:5])
TT4 = np.array(df.iloc[112:140,0:5])
TT5 = np.array(df.iloc[140:168,0:5])

"""Defining 'names', 'onsets', and 'durations' numpy object arrays for use in a dictionary to save as a matlab compatible file. 
These will serve as the inputs for SPM's model specification using multiple conditions"""
names = np.empty(15, dtype=object)
#['E1', 'E2', 'E3', 'E4', 'E5', 'D1', 'D2', 'D3', 'D4', 'D5', 'P1', 'P2', 'P3', 'P4', 'P5']
names[0] = 'E1'
names[1] = 'E2'
names[2] = 'E3'
names[3] = 'E4'
names[4] = 'E5'
names[5] = 'D1'
names[6] = 'D2'
names[7] = 'D3'
names[8] = 'D4'
names[9] = 'D5'
names[10] = 'P1'
names[11] = 'P2'
names[12] = 'P3'
names[13] = 'P4'
names[14] = 'P5'


onsets = np.empty(15, dtype=object)
onsets[0] = TT1[:,0]
onsets[1] = TT2[:,0]
onsets[2] = TT3[:,0]
onsets[3] = TT4[:,0]
onsets[4] = TT5[:,0]

onsets[5] = TT1[:,1]
onsets[6] = TT2[:,1]
onsets[7] = TT3[:,1]
onsets[8] = TT4[:,1]
onsets[9] = TT5[:,1]

onsets[10] = TT1[:,2]
onsets[11] = TT2[:,2]
onsets[12] = TT3[:,2]
onsets[13] = TT4[:,2]
onsets[14] = TT5[:,2]


durations = np.empty(15, dtype=object)
#durations = [4, 4, 4, 4, 4, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0]
for i in range(durations.shape[0]):
	if i < 5:
		durations[i] = np.array([float(4)])
	elif i > 4 and i < 10:
		durations[i] = np.array([float(9)])
	elif i > 9:
		durations[i] = np.array([float(0)])
#print(durations)


#saving matlab files for all conditions collapsed
#Onset_times_collapsed = {'Encode_all': y2[:,0], 'Delay_all': y2[:,1], 'Probe_all': y2[:,2]}
#io.savemat('/home/despoB/jam124/BiCoWM/derivatives_test/s01/GLM_conds_collapsed/Onset_times.mat', Onset_times_collapsed)

#saving matlab files for onsets by trial type
#Onsets_TT = {'names': names, 'onsets': onsets, 'durations': durations}
#io.savemat('/home/despoB/jam124/BiCoWM/derivatives_test/s01/GLM_by_trial_type/Conditions.mat', Onsets_TT)


"""Everything below is for multivariate analyses only - use just if this is the goal"""
"""Getting the onset times for multivariate analysis ==> one onset for each presentation"""
#use np.delete to remove the specific value for the onset time
multi_onsets = {}
delay_onset_times = []
tracker = 0
# a = onsets
for i in range(5,10):
	for k in range(onsets[i].shape[0]):
		a = deepcopy(onsets)
		delay_onset_times.append(a[i][k])
		#a[i][k] = None

		b = a[i] #setting b equal to the specific array in onsets for which a value at index k will be deleted
		b = np.delete(b, k) #deleting value at index k
		a[i] = b #setting a[i] equal to b, with the value at index k deleted

		multi_onsets[tracker] = a
		# a[i][k] = np.nan_to_num(a[i][k])
		# a[i][k] = onsets[i][k]
		tracker += 1



"""saving matlab files for onsets with multivariate analysis (delay onsets pulled out)"""
names = np.insert(names, [0], 'Trial', axis = 0)
#d = np.array([9.0], dtype = float)
#durations = np.insert(durations, [0], d, axis = 0)
durations = np.empty(16, dtype=object)
#durations = [9, 4, 4, 4, 4, 4, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0]

for i in range(durations.shape[0]):
	if i == 0:
		durations[i] = np.array([float(9)])
	elif i < 6:
		durations[i] = np.array([float(4)])
	elif i > 5 and i < 11:
		durations[i] = np.array([float(9)])
	elif i > 10:
		durations[i] = np.array([float(0)])

multi_conditions = {}
for i in range(len(multi_onsets)):
	specific_trial = np.array([delay_onset_times[i]])
	multi_onsets[i] = np.insert(multi_onsets[i], [0], specific_trial, axis=0)
	multi_conditions[i] = {'onsets': multi_onsets[i], 'names': names, 'durations': durations}
	io.savemat('/home/despoB/jam124/BiCoWM/batch_scripts/Conditions/Conditions' + str(i+1) + '.mat', multi_conditions[i])
