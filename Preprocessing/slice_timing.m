% List of open inputs
% File Selector (Batch Mode): Directory - cfg_files
% File Selector (Batch Mode): Filter - cfg_entry
% Slice Timing: Slice order - cfg_entry
% Slice Timing: Reference Slice - cfg_entry
nrun = X; % enter the number of runs here
jobfile = {'/home/despoB/jam124/SPM_Practice_Data/batch_scripts/slice_timing_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(4, nrun);
for crun = 1:nrun
    inputs{1, crun} = MATLAB_CODE_TO_FILL_INPUT; % File Selector (Batch Mode): Directory - cfg_files
    inputs{2, crun} = MATLAB_CODE_TO_FILL_INPUT; % File Selector (Batch Mode): Filter - cfg_entry
    inputs{3, crun} = MATLAB_CODE_TO_FILL_INPUT; % Slice Timing: Slice order - cfg_entry
    inputs{4, crun} = MATLAB_CODE_TO_FILL_INPUT; % Slice Timing: Reference Slice - cfg_entry
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
