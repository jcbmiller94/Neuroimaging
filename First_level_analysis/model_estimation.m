% List of open inputs
nrun = X; % enter the number of runs here
jobfile = {'/home/despoB/jam124/BiCoWM/batch_scripts/model_estimation_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
job_id = cfg_util('initjob', jobs);
sts    = cfg_util('filljob', job_id, inputs{:});
if sts
    cfg_util('run', job_id);
end
cfg_util('deljob', job_id);
