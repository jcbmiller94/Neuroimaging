import numpy as np
import pandas as pd
import scipy.io as io

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

for i in range(len(dictionary)):
    arr = dictionary[str(i+1)]
    a = arr[0,0]
    b = arr[0,2]
    for k in range(arr.shape[0]):
        arr[k,0] -= a
        arr[k,1] = arr[k,0] + 4.0
        arr[k,2] -= a
        arr[k,0:3] += + 442*i + 10.7
        arr[k,2] -= 0.2
    #print(arr)

y2 = np.empty((0,5))

for i in range(len(dictionary)):
    y2 = np.append(y2, dictionary[str(i+1)], axis = 0)


trial_types = {'1': np.empty((0,3)), '2': np.empty((0,3)), '3': np.empty((0,3)),'4': np.empty((0,3)), '5': np.empty((0,3))}

df = pd.DataFrame(y2, columns = ['E','D','P','Run','TT'])
df = df.sort_values(['TT','E'])
np.savetxt('Onsets_Concatenated.txt', df)

TT1 = np.array(df.iloc[0:28,0:5])
TT2 = np.array(df.iloc[28:56,0:5])
TT3 = np.array(df.iloc[56:112,0:5])
TT4 = np.array(df.iloc[112:140,0:5])
TT5 = np.array(df.iloc[140:168,0:5])


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
print(durations)

"""Getting the onset times for multivariate analysis ==> one onset for each presentation"""
#use np.delete to remove the specific value for the onset time
multi_onset_times = []
multi_onsets = onsets
for i in range(multi_onsets.shape[0]):
    for k in range(multi_onsets[i].shape[0]):
        a = multi_onsets[i]
        multi_onset_times.append(a[k])
        a[k] = None
        multi_onsets[i] = a
        """Now do just for the delay onsets!!"""


#Onset_times_collapsed = {'Encode_all': y2[:,0], 'Delay_all': y2[:,1], 'Probe_all': y2[:,2]}
#io.savemat('/home/despoB/jam124/BiCoWM/derivatives_test/s01/GLM_conds_collapsed/Onset_times.mat', Onset_times_collapsed)

#Onsets_TT = {'names': names, 'onsets': onsets, 'durations': durations}
#io.savemat('/home/despoB/jam124/BiCoWM/derivatives_test/s01/GLM_by_trial_type/Conditions.mat', Onsets_TT)
