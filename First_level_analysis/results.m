% List of open inputs
% Results Report: Select SPM.mat - cfg_files
nrun = X; % enter the number of runs here
jobfile = {'/home/despoB/jam124/BiCoWM/batch_scripts/results_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);
for crun = 1:nrun
    inputs{1, crun} = MATLAB_CODE_TO_FILL_INPUT; % Results Report: Select SPM.mat - cfg_files
end
job_id = cfg_util('initjob', jobs);
sts    = cfg_util('filljob', job_id, inputs{:});
if sts
    cfg_util('run', job_id);
end
cfg_util('deljob', job_id);
