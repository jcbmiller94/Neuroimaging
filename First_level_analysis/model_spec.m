% List of open inputs
% File Selector (Batch Mode): Directory - cfg_files
% File Selector (Batch Mode): Filter - cfg_entry
% File Selector (Batch Mode): Descend into subdirectories - cfg_menu
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Units for design - cfg_menu
% fMRI model specification: Interscan interval - cfg_entry
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Name - cfg_entry
% fMRI model specification: Value - cfg_entry
% fMRI model specification: Name - cfg_entry
% fMRI model specification: Value - cfg_entry
nrun = X; % enter the number of runs here
jobfile = {'/home/despoB/jam124/BiCoWM/batch_scripts/model_spec_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(11, nrun);
for crun = 1:nrun
    inputs{1, crun} = MATLAB_CODE_TO_FILL_INPUT; % File Selector (Batch Mode): Directory - cfg_files
    inputs{2, crun} = MATLAB_CODE_TO_FILL_INPUT; % File Selector (Batch Mode): Filter - cfg_entry
    inputs{3, crun} = MATLAB_CODE_TO_FILL_INPUT; % File Selector (Batch Mode): Descend into subdirectories - cfg_menu
    inputs{4, crun} = MATLAB_CODE_TO_FILL_INPUT; % fMRI model specification: Directory - cfg_files
    inputs{5, crun} = MATLAB_CODE_TO_FILL_INPUT; % fMRI model specification: Units for design - cfg_menu
    inputs{6, crun} = MATLAB_CODE_TO_FILL_INPUT; % fMRI model specification: Interscan interval - cfg_entry
    inputs{7, crun} = MATLAB_CODE_TO_FILL_INPUT; % fMRI model specification: Scans - cfg_files
    inputs{8, crun} = MATLAB_CODE_TO_FILL_INPUT; % fMRI model specification: Name - cfg_entry
    inputs{9, crun} = MATLAB_CODE_TO_FILL_INPUT; % fMRI model specification: Value - cfg_entry
    inputs{10, crun} = MATLAB_CODE_TO_FILL_INPUT; % fMRI model specification: Name - cfg_entry
    inputs{11, crun} = MATLAB_CODE_TO_FILL_INPUT; % fMRI model specification: Value - cfg_entry
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
