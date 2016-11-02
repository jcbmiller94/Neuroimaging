clear all;

% get and set paths
scriptdir = pwd;
addpath('/home/despoB/jam124/BiCoWM/batch_scripts'); % add any necessary paths (e.g., to initialize_vars)

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