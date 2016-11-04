function [b] = initialize_trial_conditions(subjects, i)

% SPM info
b.spmDir = fileparts(which('spm'));         % path to SPM installation

% Directory information
dataDir = '/home/despoB/jam124/BiCoWM/derivatives_test/'; %path to MRI data
b.curSubj = subjects{1};
b.dataDir = strcat(dataDir,b.curSubj,'/');  % make data directory subject-specific
b.funcRuns = {'RawEPI'};  % folders containing functional images
b.anatT1 = 'Structural';  % folder containing T1 structural
b.behavDir = '/home/despoB/jam124/BiCoWM/behav/Pilot1_JS/'; 
b.conditions = strcat('/home/despoB/jam124/BiCoWM/batch_scripts/Conditions/', 'Conditions', num2str(i), '.mat');

%make new directory for each set of conditons (each trial) for the Beta maps
mkdir(strcat(dataDir, b.curSubj, '/GLM_multivariate/Conditions', num2str(i)));
b.spmMatDir = strcat(dataDir, b.curSubj, '/GLM_multivariate/Conditions', num2str(i));
b.spmMat = strcat(b.spmMatDir, '/SPM.mat');
% Call sub-function to run exceptions
%b = run_exceptions(b);

end


