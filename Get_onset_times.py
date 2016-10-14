import numpy as np
import pandas as pd
import scipy.io as io

# read in text file
x = np.genfromtxt('JSpilot1_resultsTXT.txt', names = True, dtype = None)

y = np.zeros((168,4))

y[:,0] = x['raw_start_time']
y[:,2] = x['raw_probe_time']
y[:,3] = x['cbRun']
print(y[167])

dictionary = {'1': np.zeros((24,4)), '2': np.zeros((24,4)), '3': np.zeros((24,4)),'4': np.zeros((24,4)), '5': np.zeros((24,4)), '6': np.zeros((24.4)), '7': np.zeros((24.4))}

for i in range(len(dictionary)):
    dictionary[str(i+1)] = y[(i*24):((i+1)*24)]
    #print(dictionary[str(i+1)])

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

y2 = np.empty((0,4))

for i in range(len(dictionary)):
    y2 = np.append(y2, dictionary[str(i+1)], axis = 0)

Onset_times = {'Encode_all': y2[:,0], 'Delay_all': y2[:,1], 'Probe_all': y2[:,2]}
io.savemat('Onset_times.mat', Onset_times)

np.savetxt('Onsets_Concatenated.txt', y2)
