clear all;

% get and set paths
scriptdir = pwd;
addpath('/home/despoB/jam124/BiCoWM/batch_scripts'); % add any necessary paths

% Specify variables
subjects = {'s01'};
batch_functions = {'model_specification_job' 'spm_fmri_concatenate_job' 'model_estimation_job'};
scans = [221 221 221 221 221 221 221] %length of each run in TRs, for concatenation
%Loop through each different delay trial (168) and run a GLM for each one
%Trials are in chronological order by trial type (1-5) 

for i = 1:168
    b = initialize_trial_conditions(subjects, i);
    multi_model_specification_job(b);
    spm_fmri_concatenate(b.spmMat, scans);
    multi_model_estimation_job(b);
    disp(strcat('Trial ', num2str(i), ' completed. SPM and beta maps:  ', b.spmMatDir));
end

    
    


