%Getting start times from the text file of outputted behavioral data
BehavDir = '/home/despoB/jam124/BiCoWM/behav/Pilot1_JS'
addpath(BehavDir)
a = dir(fullfile(BehavDir, '**.txt'))
BehavFile = strcat(BehavDir, '/', a.name())


T = tdfread(BehavFile) %turns columns into elements within the data structure T

T.start_time_norm = zeros(168, 1) %make new start times that will start from time t = 0
T.delay_start_time = zeros(168, 1)
T.probe_time_norm = zeros(168, 1)

start_time = T.raw_start_time(1) %finding when the stimuli started at first

for k = 1: length(T.raw_start_time)%create the new stim times starting from 0 
    T.start_time_norm(k) = (T.raw_start_time(k) - start_time) + 0.2 + 10.5*(T.cbRun(k))
    T.delay_start_time(k) = T.start_time_norm(k) + 4.0
    T.probe_time_norm(k) = T.raw_probe_time(k) - start_time + 10.5*(T.cbRun(k))
end

%making regressors for the 7 different runs in the scanner
%run1_reg = zeros(1547, 1)
%run2_reg = zeros(1547, 1)
%run3_reg = zeros(1547, 1)
%run4_reg = zeros(1547, 1)
%run5_reg = zeros(1547, 1)
%run6_reg = zeros(1547, 1)
%run7_reg = zeros(1547, 1)
Run_regs = cell(7,1)

for i = 1:7
  Run_regs{i} = zeros(1547, 1)
end

for i = 1:1547
    if i < 222
        Run_regs{1}(i) = 1;
    elseif i > 221 & i < 443
        Run_regs{2}(i) = 1;
    elseif i > 442 & i < 664
       Run_regs{3}(i) = 1;
    elseif i > 663 & i < 885
       Run_regs{4}(i) = 1;   
    elseif i > 884 & i < 1106
        Run_regs{5}(i) = 1;    
    elseif i > 1105 & i < 1327
        Run_regs{6}(i) = 1; 
    elseif i > 1326 & i < 1548
        Run_regs{7}(i) = 1; 
    end
end

R = cell2mat(Run_regs)
R = reshape(R, 1547, 7)

save(strcat(BehavDir, '/R.mat'), 'R')


results_table = struct2table(T) %converting data struct into a table


%results_table = sortrows(table,'cbTrialType','ascend')

%table1 = table(1:28,1:27);
%table2 = table(29:56,1:27);
%table3 = table(57:112,1:27);
%table4 = table(113:140,1:27);
%table5 = table(141:end,1:27);

%tt1 = []; tt2 = []; tt3 = []; tt4 = []; tt5 = [];

%The following values are divided by 2 to calculate in TRs!!
SOT = cell(5, 1) %cellarray to be filled with stimulus onset times
start_time_norm = []
start_time_norm(:,1) = table2array(results_table(1:end, 'start_time_norm'))
start_time_norm(:,2) = table2array(results_table(1:end, 'cbTrialType'))
for k = 1: height(results_table) %looping through start times from 0 to give 5 elements in the cellarray SOT correpsonding to the times for each trial type 
x = start_time_norm(k,2)
SOT{x}(end+1) = start_time_norm(k,1)
end
save(strcat(BehavDir, '/SOT.mat'), 'SOT')


DOT = cell(5, 1) %cellarray to be filled with delay onset times
delay_time_norm = []
delay_time_norm(:,1) = table2array(results_table(1:end, 'delay_start_time'))
delay_time_norm(:,2) = table2array(results_table(1:end, 'cbTrialType'))
for k = 1: height(results_table) % looping delay start times from 0 to give 5 elements in the cellarray DOT correpsonding to the times for each trial type 
y = delay_time_norm(k,2)
DOT{y}(end+1) = delay_time_norm(k,1)
end
save(strcat(BehavDir, '/DOT.mat'), 'DOT')



POT = cell(5, 1) %cellarray to be filled with delay onset times
probe_time_norm = []
probe_time_norm(:,1) = table2array(results_table(1:end, 'probe_time_norm'))
probe_time_norm(:,2) = table2array(results_table(1:end, 'cbTrialType'))
for k = 1: height(results_table) % looping probe start times from 0 to give 5 elements in the cellarray DOT correpsonding to the times for each trial type 
z = probe_time_norm(k,2)
POT{z}(end+1) = probe_time_norm(k,1)
end
save(strcat(BehavDir, '/POT.mat'), 'POT')


%making a *.mat file compatible with the mulitple conditions entry of SPM
names = cell(1, 15)
names{1} = 'S1'; names{2} = 'S2'; names{3} = 'S3'; names{4} = 'S4'; names{5} = 'S5'; names{6} = 'D1'; names{7} = 'D2'; names{8} = 'D3'; names{9} = 'D4'; names{10} = 'D5'; names{11} = 'P1'; names{12} = 'P2'; names{13} = 'P3'; names{14} = 'P4'; names{15} = 'P5';
onsets = cell(1,15)
durations = cell(1,15)
durations{1} = 4; durations{2} = 4; durations{3} = 4; durations{4} = 4; durations{5} = 4; durations{6} = 9; durations{7} = 9; durations{8} = 9; durations{9} = 9; durations{10} = 9; durations{11} = 0; durations{12} = 0; durations{13} = 0; durations{14} = 0; durations{15} = 0;
for i = 1:15
    if i < 6
        onsets{i} = SOT{i}
    elseif i > 5 & i < 11
        onsets{i} = DOT{i-5}
    elseif i > 10
        onsets{i} = POT{i-10}
    end
end

save(strcat(BehavDir, '/Conditions.mat'), 'names', 'durations', 'onsets')
    
  


