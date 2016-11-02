function [b] = initialize_vars(subjects,i)

% SPM info
b.spmDir = fileparts(which('spm'));         % path to SPM installation

% Directory information
dataDir = '/home/despoB/jam124/BiCoWM/derivatives_test/'; %path to MRI data
b.curSubj = subjects{i};
b.dataDir = strcat(dataDir,b.curSubj,'/');  % make data directory subject-specific
b.funcRuns = {'RawEPI'};  % folders containing functional images
b.anatT1 = 'Structural';  % folder containing T1 structural
b.behavDir = '/home/despoB/jam124/BiCoWM/behav/Pilot1_JS/'
% Call sub-function to run exceptions
%b = run_exceptions(b);

end


% Subject-specific exceptions (e.g., deviations from naming convention)
%function b = run_exceptions(b)

%if strcmp(b.curSubj,'s01')
 %   if isfield(b,'funcRuns')
  %      b.funcRuns = {'epi_0002' 'epi_0003'}; % e.g., if s01 had different run numbers
   % end
%end

%end