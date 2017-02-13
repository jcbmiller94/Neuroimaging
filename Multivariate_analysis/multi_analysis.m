%-----------------------------------------------------------------------
% MULTIVARIATE ANALYSIS FOR ESTIMATION OF BETA MAPS
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging) 
%

% Run this script to conduct a multivariate analysis on a session of data
%  from the BiCoWM task. See the initialize_trial_conditions file for
%  information of changing the files and paths for sesisons 

% Notes:
% - runtime ~ 24 hrs
% - this framework uses preprocessed, but unsmoothed .nii files 
% - all Beta maps are saved as 'con_0001.nii' in their respective folder
% - the spm_fmri_concatenate function must be in the same directory as the
%    mutlivariate analysis scripts (this same one), to be changed later 

% TO CHANGE FOR EACH USE:
%  - subjects = {} enter a string for the subject label being run (e.g.'s01')
%  - scans = [] array of the number of TRs in each run for the session,
%    needed for the concatenation function
%-----------------------------------------------------------------------
clear all;

% get and set paths
scriptdir = pwd;
addpath('/home/despoB/jam124/BiCoWM/batch_scripts'); % add any necessary paths

% Specify variables
subjects = {'s01'};
%batch_functions = {'model_specification_job' 'spm_fmri_concatenate_job' 'model_estimation_job'};
%scans = [221 221 221 221 221 221 221] %length of each run in TRs, for concatenation
scans = repmat(221, 1, 14)
%Loop through each different delay trial (168) and run a GLM for each one
%Trials are in chronological order by trial type (1-5) 

for i = 1:168
    b = initialize_trial_conditions(subjects, i);
    multi_model_specification_job(b);
    spm_fmri_concatenate(b.spmMat, scans);
    multi_model_estimation_job(b);
    disp(strcat('Trial ', num2str(i), ' completed. SPM and beta maps:  ', b.spmMatDir));
end

    
    


