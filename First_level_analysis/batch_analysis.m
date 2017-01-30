%-----------------------------------------------------------------------
% COMBINED UNIVARIATE ANALYSIS FOR ESTIMATION OF BETA MAPS
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging) 
%

% Run this script to conduct a combined univariatee analysis on multiple 
% sessions of data from the BiCoWM task. See the initialize_vars 
% file for information of changing the files and paths for sesisons 

% Notes:
% - runtime _ hrs
% - this framework uses preprocessed .nii files 
% - the spm_fmri_concatenate function must be in the same directory as the
%    analysis scripts (this same one), to be changed later 
% - a directory for the results output (as specified in
%   initialize_vars_analysis) must already exist 
%
% TO CHANGE FOR EACH USE:
%  - subjects = {} enter a string for the subject label being run (e.g.'s01') 
%-----------------------------------------------------------------------
clear all;

% get and set paths
scriptdir = pwd;
addpath('/home/despoB/jam124/BiCoWM/batch_scripts/First_level_analysis/'); % add any necessary paths (e.g., to initialize_vars)

% Specify variables
outLabel = 'basic_analyze'; %output label
subjects = {'s01'};
batch_functions = {'model_specification_job' 'spm_fmri_concatenate_job' 'model_estimation_job' 'contrast_manager_job' 'results_job'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialize error log
%errorlog = {}; ctr=1;

% loop over batch functions
for m=1:length(batch_functions)
    fprintf('\nFunction: %s\n',batch_functions{m});

    % loop over subjects
    for i=1:length(subjects)
        fprintf('\nWorking on %s...\n',subjects{i});

        % get subject-specific variables
        b = initialize_vars_analysis(subjects,i);

        % move to subject data folder
        cd(b.dataDir);

        %run matlabbatch job
        try

            %run current job function, passing along subject-specific inputs
            batch_output = eval(strcat(batch_functions{m},'(b)'));

            %save output (e.g., matlabbatch) for future reference
            outName = strcat(outLabel,'_',date,'_',batch_functions{m});
            save(outName, 'batch_output');
        end

        cd(scriptdir);
    end

end