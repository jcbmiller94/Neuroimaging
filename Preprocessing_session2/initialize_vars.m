%-----------------------------------------------------------------------
% PREPROCESSING CONDITION INITIALIZATION 
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging)
%
% Intialize the settings for the preprocessing of the first session for 
%  the BiCoWM task 
%
% TO CHANGE FOR EACH USE: 
%  Data location: 
%  - b.dataDir
%  - b.funcRuns:'RawEPI_Session2' 
%  - b.sess: 'Session2' , etc. 
% 
%-----------------------------------------------------------------------

function [b] = initialize_vars(subjects,i)

% SPM info
b.spmDir = fileparts(which('spm'));         % path to SPM installation

% Directory information

% Path to the directory containing the subject directories 
dataDir = '/home/despoB/jam124/BiCoWM/derivatives_test/'; 
% Current subject, i.e. 's01'  
b.curSubj = subjects{i};
% building the name of the dat directory where the data for each subject is
b.dataDir = strcat(dataDir,b.curSubj,'/'); 
% folder(s) containing functional images
b.funcRuns = {'RawEPI_Session2'}; 
b.funcSess1 = 'RawEPI'; 
% folder containing T1 structural
b.anatT1 = 'Structural';  
b.behavDir = '/home/despoB/jam124/BiCoWM/behav/Pilot1_JS/'
% Call sub-function to run exceptions
%b = run_exceptions(b);
b.sess = 'Session2'

end


% Subject-specific exceptions (e.g., deviations from naming convention)
%function b = run_exceptions(b)

%if strcmp(b.curSubj,'s01')
 %   if isfield(b,'funcRuns')
  %      b.funcRuns = {'epi_0002' 'epi_0003'}; % e.g., if s01 had different run numbers
   % end
%end

%end