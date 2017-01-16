"""
Extract onset times from output of BiCoWM_v10 text files

Jacob Miller (github.com/jcbmiller94), 1/10/17

Assumptions:
- encoding, delay, and probe durations of (4, 10, 0) s
- ('raw_start_time', 'raw_probe_time', 'cbRun', 'cbTrialType') are the column names,
    otherwise this should be specified

"""

# importing all the good stuff
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import scipy.io as io
import scipy.stats as stats
import seaborn as sns

import json
from copy import deepcopy
import os.path
from os.path import dirname, join as pjoin
import sys
import argparse

np.set_printoptions(precision=2)  # print arrays to 2 DP

# getting the relative path info from the script
script_dir = dirname(os.path.abspath(__file__)) # directory path where script is located
print('Script dir:' + script_dir)

def read_txt_file(fname, fname2 = '', fname3 = ''):
    """
    Read a tab-delimited text file generated from the BiCoWM task and generate
    a dictionary grouped by run number (relies on pandas DataFrame approach)

    Parameters
    ----------
    fname: path to a tab-delimited .txt file

    fname2: path to a tab-delimited .txt file, session 2 of data

    fname3: path to a tab-delimited .txt file, session 3 of data

    Returns
    -------
    run_dict: dictionary with run number as key to an array of size (trial x column)

    """
    # read in tab-delimited text file
    df = pd.read_csv(fname, header = 0, sep = '\s+')

    # calculate number of runs based on max value of 'cbRun' columns values
    n_runs = int(df['cbRun'].max())

    # if 2nd and 3rd session filenames are given, adjust run numbers and concatenate
    #  into one large data frame to then split by run
    if len(fname2) > 0:
        df2 = pd.read_csv(fname2, header = 0, sep = '\s+')
        df2['cbRun'] += n_runs
        frames = [df, df2]
        df = pd.concat(frames)
        n_runs = int(df['cbRun'].max())

    if len(fname3) > 0:
        df3 = pd.read_csv(fname2, header = 0, sep = '\s+')
        df3['cbRun'] += n_runs
        frames = [df, df3]
        df = pd.concat(frames)

    # # change non-numeric values to NaNs for the conditons of interest
    # df['move_init_msecRT'] = pd.to_numeric(df['move_init_msecRT'], errors = 'coerce')
    # df = df.dropna()

    # use pandas groupby funciton to group by the run number
    grouped_run = df.groupby('cbRun')

    # narrow down the columns of interest, specified by the list
    grouped_run = grouped_run[('raw_start_time', 'raw_probe_time', 'cbRun', 'cbTrialType')]

    # loop through and create dictionary with separate entry for each run
    run_dict = {}
    for i in range(n_runs):
        run_dict[i+1] = np.array(grouped_run.get_group(i+1), dtype = np.float64)

    return run_dict

def norm_onset_times(run_dict, run_length, TR):
    """
    Go through dictionary of the runs and normalize onset times for each run

    Parameters
    ----------
    run_dict: dictionary with key as runs

    run_length: int (# of TRs in a run)

    TR: int (repetition time)

    Returns
    -------
    onsets_by_run: array (trials x (encoding onset, delay onset, probe onset, run, trial type))
        array of onset times (normalized for run lengths) for encoding, delay, probe sorted by run

    """

    col = np.zeros(run_dict[1].shape[0])
    # loop through each array in the dictionary
    for i in range(len(run_dict)):
        # insert column of zeros into the array, which will become the delay period onset times
        run_dict[i+1] = np.insert(run_dict[i+1], 1, col, axis = 1)
        run_arr = run_dict[i+1]
        #run_arr = np.insert(run_arr, 1, col, axis = 1)
        # time of first stim onset in run
        first_start_time = run_arr[0,0]
        # time of first probe onset in run
        first_probe_time = run_arr[0,2]

        #for k in range(run_arr.shape[0]):

        # set first encoding time of run to zero, all other times in this run relative to this point
        run_arr[:,0] -= first_start_time
        # add 4 s for the delay onset time
        run_arr[:,1] += run_arr[:,0] + 4.0
        # set first probe time of run relative to first stim time
        run_arr[:,2] -= first_start_time
        # adjusting times for the start of each run (adding length of runs plus 10.7 scanner delay)
        run_arr[:,0:3] += (run_length * TR * i) + 10.7
        run_arr[:,2] -= 0.2

    # combine all runs into one array
    onsets_by_run = np.empty((0,run_dict[1].shape[1]))
    for i in range(len(run_dict)):
    	onsets_by_run = np.append(onsets_by_run, run_dict[i+1], axis = 0)

    return onsets_by_run

def collapsed_conds_files(onsets_by_run, fname, combined = False):
    """
    Saves .txt and .mat files for onset times of encoding, delay, and probe sorted by run
     and collapsed across trial types

    Parameters
    ----------
    onsets_by_run: array size (trials x (encoding onset, delay onset, probe onset, run, trial type))

    Returns
    -------

    """
    if combined == True:
        suffix = '_sess_all'
    else:
        suffix = '_sess_1'

    # save text file of onset times sorted in order of run
    np.savetxt('Onsets_Collapsed_' + fname.split('.')[0] + '.txt', onsets_by_run)

    # save matlab files for all conditions collapsed
    Onset_times_collapsed = {'Encode_all': onsets_by_run[:,0], 'Delay_all': onsets_by_run[:,1], 'Probe_all': onsets_by_run[:,2]}
    io.savemat('Onsets_Collapsed_' + fname.split('.')[0] + suffix + '.mat', Onset_times_collapsed)

    return

def split_conds_files(onsets_by_run, fname, combined = False):
    """
    Saves .txt and .mat files for onset times of each trial type for encoding, delay,
     and probe phases. Sorted by trial type and then encoding time

    Trial types: (1) Load 2 - Face (2) Load 2 - Scenes (3) Load 4 - Mixed (4) Load 4 - Face (5) Load 4 - Scene

    Parameters
    ----------
    onsets_by_run: array size (trials x (encoding onset, delay onset, probe onset, run, trial type))

    Returns
    -------

    onsets: array size (15,)
      object array of onset times split up by the trial types

    """

    if combined == True:
        suffix = '_sess_all'
    else:
        suffix = '_sess_1'

    # Encoding, delay, probe, run number, trial type
    df = pd.DataFrame(onsets_by_run, columns = ['E','D','P','Run','TT'])

    # sort data frame based
    df = df.sort_values(['TT','E'])

    # groups by trial type for easier access
    grouped_TT = df.groupby('TT')
    TT1 = np.array(grouped_TT.get_group(1), dtype = np.float64)
    TT2 = np.array(grouped_TT.get_group(2), dtype = np.float64)
    TT3 = np.array(grouped_TT.get_group(3), dtype = np.float64)
    TT4 = np.array(grouped_TT.get_group(4), dtype = np.float64)
    TT5 = np.array(grouped_TT.get_group(5), dtype = np.float64)

    # save text file of onset times sorted by trial type
    np.savetxt('Onsets_Split_' + fname.split('.')[0] + suffix + '.txt', df)

    # making names, onsets, and durations np object arrays to a dictionary to save as a .mat file
    #  these will serve as the inputs for SPM's model specification using multiple conditions
    names = np.array(['E1', 'E2', 'E3', 'E4', 'E5', 'D1', 'D2', 'D3', 'D4', 'D5', 'P1', 'P2', 'P3', 'P4', 'P5'], dtype = object)

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
    durations[:5] = np.array([float(4)])
    durations[5:10] = np.array([float(9)])
    durations[10:] = np.array([float(0)])

    # save matlab file for multiple conditions for use in GLM
    Onsets_TT = {'names': names, 'onsets': onsets, 'durations': durations}
    io.savemat('Conditions_' + fname.split('.')[0] + suffix + '.mat', Onsets_TT)

    return df, onsets, names, durations

def multi_onset_files(df, onsets, names, durations):
    """
    Saves .txt and .mat files for multivariate onset times, with the delay onset for
     each trial of each trial type removed and placed in a new column as a single regresor

    Trial types: (1) Load 2 - Face (2) Load 2 - Scenes (3) Load 4 - Mixed (4) Load 4 - Face (5) Load 4 - Scene

    Parameters
    ----------

    df: pandas DataFrame sorted by trial type and onset times, from which the trial type order will be extracted

    onsets: array size (15,)
        object array of onset times split up by the trial types

    names: array size (15,)
        strings of the labe for each trial type

    durations: array size (15,)
        floats of the duration of each trial type

    Returns
    -------

    """

    #  use np.delete to remove the specific value for the delay onset time
    multi_onsets = {}
    delay_onset_times = [] #  array to which all delay onset times will be added
    tracker = 0

    for i in range(5,10):
    	for k in range(onsets[i].shape[0]):
            #  make a copy of the onsets object array
    		a = deepcopy(onsets)
    		delay_onset_times.append(a[i][k])
            #  setting b equal to the specific array in onsets for which a value at index k will be deleted
    		b = a[i]
    		b = np.delete(b, k) #deleting value at index k
    		a[i] = b #setting a[i] equal to b, with the value at index k deleted

    		multi_onsets[tracker] = a

    		tracker += 1

    #  saving .mat files for onsets with multivariate analysis (delay onsets pulled out)

    names = np.insert(names, [0], 'Trial', axis = 0)
    # d = np.array([9.0], dtype = float)
    # durations = np.insert(durations, [0], d, axis = 0)
    durations = np.insert(durations, [0], np.array([float(9)]), axis = 0)
    # durations = np.empty(16, dtype=object)
    # durations = [9, 4, 4, 4, 4, 4, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0]

    # for i in range(durations.shape[0]):
    # 	if i == 0:
    # 		durations[i] = np.array([float(9)]) # because first column is the delay event, with a duration of 9 seconds
    # 	elif i < 6:
    # 		durations[i] = np.array([float(4)])
    # 	elif i > 5 and i < 11:
    # 		durations[i] = np.array([float(9)])
    # 	elif i > 10:
    # 		durations[i] = np.array([float(0)])

    # check the filepath of the current script
    directory = pjoin(script_dir, 'conditions_multivariate')
    if not os.path.exists(directory):
        os.makedirs(directory)

    multi_conditions = {}
    for i in range(len(multi_onsets)):
        specific_trial = np.array([delay_onset_times[i]])
        multi_onsets[i] = np.insert(multi_onsets[i], [0], specific_trial, axis=0)
        multi_conditions[i] = {'onsets': multi_onsets[i], 'names': names, 'durations': durations}
        save_name = 'Conditions' + str(i+1) + '.mat'
        io.savemat(pjoin(directory, save_name), multi_conditions[i])
        #io.savemat(save_path, multi_conditions[i])

    #  save the list of trial type order for the subsequent multvariate analyses (for delay trials)
    TT_vector = np.ones((3, 168))
    for i in range(TT_vector.shape[-1]):
    	TT_vector[0, i] = i + 1
    	TT_vector[1, i] = int(df.iloc[i, 4])
    	TT_vector[2, i] = df.iloc[i, 1]
    np.savetxt('TrialType_order_multivariate.txt', TT_vector)

    return


fname = 'JSpilot1_resultsTXT.txt'
d = read_txt_file(fname)
onsets_by_run = norm_onset_times(d, 221, 2)
df, onsets, names, durations = split_conds_files(onsets_by_run, fname)
multi_onset_files(df, onsets, names, durations)


def main():

    parser = argparse.ArgumentParser()

    parser.add_argument("-f", "--file", type = str, required = True)
    parser.add_argument("-f2", "--file2", type = str, required = False)
    parser.add_argument("-f3", "--file3", type = str, required = False)
    parser.add_argument("-tr", "--TR", type = int, required = False, default = 2)
    parser.add_argument("-rl", "--run_length", type = int, required = False, default = 221)

    args = parser.parse_args()
    print(args)

    #run_realignment(args.file, smooth_fwhm = args.smooth, num_pass = args.num_pass, prefix = args.prefix)

    # read filenames provided
    fname = args.file

    if args.file2 is not None:
        d = read_txt_file(fname, fname2 = args.file2)
        combined = True
    elif args.file2 is not None and args.file3 is not None:
        d = read_txt_file(fname, fname2 = args.file2, fname3 = args.file3)
        combined = True
    else:
        d = read_txt_file(fname)
        combined = False

    # extract onset times and save out files
    onsets_by_run = norm_onset_times(d, args.run_length, args.TR)
    collapsed_conds_files(onsets_by_run, fname, combined = combined)
    df, onsets, names, durations = split_conds_files(onsets_by_run, fname, combined = combined)
    multi_onset_files(df, onsets, names, durations)

if __name__ == '__main__':
    main()
