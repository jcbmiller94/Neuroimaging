%-----------------------------------------------------------------------
% UNIVARIATE ANALYSIS CONDITION INITIALIZATION 
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging)
%
% Intialize the settings for the first-level analysis for the BiCoWM task 
%
% TO CHANGE FOR EACH USE: 
%  Data location: 
%  - b.dataDir
%  - b.spmDir: folder name where contrasts and results will be saved out 
%  - b.funcRuns: {'RawEPI_Session2', 'RawEPI_Session2'}
%  - b.conditions: .mat file for multiple conditions for GLM (output from 
%       Get_onset_times_bcwm.py script)
%  - b.scans: array of number of TRs in each run, across sessions
%-----------------------------------------------------------------------

function [b] = initialize_vars_analysis(subjects,i)

% SPM info
%b.spmDir = fileparts(which('spm'));         % path to SPM installation

% Directory information
dataDir = '/home/despoB/jam124/BiCoWM/derivatives_test/'; %path to fMRI data
b.curSubj = subjects{i};
b.dataDir = strcat(dataDir, b.curSubj,'/');  % make data directory subject-specific
b.funcRuns = {'RawEPI', 'RawEPI_Session2'};  % folders containing functional images from all of the subject's sessions
b.anatT1 = 'Structural';  % folder containing T1 structural
b.behavDir = '/home/despoB/jam124/BiCoWM/behav/Pilot1_JS/' ;
b.spmDir = strcat(dataDir, b.curSubj, '/GLM_univariate_combined');
b.spmMat = strcat(b.spmDir, '/SPM.mat'); 
b.conditions = '/home/despoB/jam124/BiCoWM/batch_scripts/Conditions_Pilot1_JS_sess_all.mat'; %mat file containing {names} {onsets} {durations}
% Call sub-function to run exception
%b = run_exceptions(b);

% # of TRs per run, 1 (rows), 14 (runs/columns)
b.scans = repmat(221, 1, 14); 

disp('test'); 

end


% Subject-specific exceptions (e.g., deviations from naming convention)
%function b = run_exceptions(b)

%if strcmp(b.curSubj,'s01')
 %   if isfield(b,'funcRuns')
  %      b.funcRuns = {'epi_0002' 'epi_0003'}; % e.g., if s01 had different run numbers
   % end
%end

%end