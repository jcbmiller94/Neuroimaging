%-----------------------------------------------------------------------
% PREPROCESSING SLICE TIMING CORRECTION
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging)
%
% Use SPM's slice timing correction functions to interpolate on data from 
%  the BiCoWM task 
%
% TO CHECK FOR EACH USE: 
%  - Number of slices (e.g., 64) 
%  - TR (e.g., 2)
%  - TA (e.g., 1.96875)
%  - Slice timing (list of slice order OR time of each slice in ms; for 
%       multiband, use slice times in ms)
%  - Reference slice (use slice number of time of slice in ms based on list
%       used for slice timing) 
%
%-----------------------------------------------------------------------
function [matlabbatch] = job_slice_timing(b)

matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{1}]}; % File Selector (Batch Mode): Directory - cfg_files
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^s'; % realigned files with prefix 's'  
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList'; % File Selector (Batch Mode): Do not descend into subdirectories - cfg_menu

matlabbatch{2}.spm.temporal.st.scans{1}(1) = cfg_dep('File Selector (Batch Mode): Selected Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.spm.temporal.st.nslices = 64; % Number of slices per TR
matlabbatch{2}.spm.temporal.st.tr = 2; % TR (seconds)
matlabbatch{2}.spm.temporal.st.ta = 1.96875; %TA = TR - TR/N (where N = number of slices) 
% slice timing order, in this case we have specified the millisecond timing for each individual slice 
matlabbatch{2}.spm.temporal.st.so = [0,942.500000000000,1882.50000001000,815,1757.50000001000,690,1632.50000001000,565,1505,440,1380,315,1255,190,1130,62.5000000000000,1005,1945.00000001000,880,1820.00000001000,752.500000000000,1695.00000001000,627.500000000000,1570.00000001000,502.500000000000,1442.50000000000,377.500000000000,1317.50000000000,252.500000000000,1192.50000000000,125,1067.50000000000,0,942.500000000000,1882.50000001000,815,1757.50000001000,690,1632.50000001000,565,1505,440,1380,315,1255,190,1130,62.5000000000000,1005,1945.00000001000,880,1820.00000001000,752.500000000000,1695.00000001000,627.500000000000,1570.00000001000,502.500000000000,1442.50000000000,377.500000000000,1317.50000000000,252.500000000000,1192.50000000000,125,1067.50000000000]; %slice order; descending: [N N-1 N-2 ... last slice]; ascending: [1 2 ... N] 
matlabbatch{2}.spm.temporal.st.refslice = 0; % Reference slice (usually the median slice number)
matlabbatch{2}.spm.temporal.st.prefix = 'a'; % Prefix of file outputs 

name = strcat(b.sess, '_slice_timing_batch.mat'); 
save(name, 'matlabbatch');

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end



