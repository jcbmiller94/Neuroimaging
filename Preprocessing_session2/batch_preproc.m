%-----------------------------------------------------------------------
% PREPROCESSING SPM PIPELINE - SESSION #2 
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging) 
%
% Run this script to conduct specfied preprocessing steps on data from the 
%  BiCoWM task. See the initialize_vars file for
%  information of changing the files and paths for sesisons 
%
% Notes:
% -  
%
% TO CHANGE FOR EACH USE:
% - subjects = {} enter a string for the subject label being run (e.g.'s01')
% - batch_functions = {} list of strings of the names of scripts in the same
%   directory for each individual preprocessing step 
%-----------------------------------------------------------------------

clear all;

% get and set paths
scriptdir = pwd;

% Path to the directory containing the Preprocessing scripts and the
%  initilize_vars file, whihc contains the names of the folders for the
%  EPI and structural data, etc 
addpath('/home/despoB/jam124/BiCoWM/batch_scripts/Preprocessing_session2/'); 

% Specify variables

% Output label for the .mat file saving the input parameters for each
%  preprocessing step - these are set to save in the same directory as the
%  EPI and structural folders
outLabel = 'Basic_pp_Session2'; 

% List of subject labels, will be used for savng files and accessing paths 
%  important: this much match the label of the folder containing the EPI
%  and structural data for the subject, unless specific elsewhere 
subjects = {'s01'};

% List of the functins (scripts) that will be called on in the loop below
%  must match the filenames correctly 
batch_functions = {'realign_estimate_only_job' 'slice_timing_job' 'coreg_estimate_reslice_job' 'smooth_job'};

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
        b = initialize_vars(subjects,i);

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