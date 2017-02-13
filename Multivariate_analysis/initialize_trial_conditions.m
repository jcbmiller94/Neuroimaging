%-----------------------------------------------------------------------
% MULTIVARIATE CONDITION IN|ITIALIZATION 
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging)
%
% intialize the settings for the multivariate analysis, which constructs
%  Beta maps for the first regressor specified in the GLM (here, that is a
%  given delay onset time) 
%
% TO CHANGE FOR EACH USE: 
%  Data location: 
%  - b.funcRuns:'RawEPI' or 'RawEPI_Session2' 
%  - b.conditions: '/home/despoB/jam124/BiCoWM/batch_scripts/Conditions_session2/'
%   (filepath where onset times (in .mat files) for design are specified, as run by the
%   Get_Onset_Times.py script) 
%  - b.spmMatDir: strcat(dataDir, b.curSubj, '/GLM_multivariate_session2/Conditions', num2str(i))
%  
%
%  Making directories: 
%   each time this function is called, a Conditions folder (e.g.
%   Conditons45) is made in the locations specified at the bottom of the
%   script (e.g. '/GLM_multivariate_session2/Conditions') 
%-----------------------------------------------------------------------
function [b] = initialize_trial_conditions(subjects, i)

% SPM info
b.spmDir = fileparts(which('spm'));         % path to SPM installation

% Directory information
dataDir = '/home/despoB/jam124/BiCoWM/derivatives_test/'; % path to MRI data
b.curSubj = subjects{1};
b.dataDir = strcat(dataDir,b.curSubj,'/');  % make data directory subject-specific
b.funcRuns = { 'RawEPI' 'RawEPI_Session2'};  % folders containing functional images e.g. 'RawEPI' or 'RawEPI_Session2' 
b.anatT1 = 'Structural';  % folder containing T1 structural 
b.behavDir = '/home/despoB/jam124/BiCoWM/behav/Pilot1_JS/'; 
b.conditions = strcat('/home/despoB/jam124/BiCoWM/batch_scripts/conditions_multivariate/', 'Conditions', num2str(i), '.mat');

%make new directory for each set of conditons (each trial) for the Beta maps
mkdir(strcat(dataDir, b.curSubj, '/GLM_multivariate_combined/Conditions', num2str(i))); 
b.spmMatDir = strcat(dataDir, b.curSubj, '/GLM_multivariate_combined/Conditions', num2str(i));
b.spmMat = strcat(b.spmMatDir, '/SPM.mat');
% Call sub-function to run exceptions
%b = run_exceptions(b);

end


