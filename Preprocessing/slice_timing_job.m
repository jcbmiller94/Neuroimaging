%-----------------------------------------------------------------------
% Job saved on 15-Sep-2016 11:04:40 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
%-----------------------------------------------------------------------
function [matlabbatch] = job_slice_timing(b)

matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{1}]}; % File Selector (Batch Mode): Directory - cfg_files
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^r'; %realigned files with prefix 'r'  
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList'; % File Selector (Batch Mode): Do not descend into subdirectories - cfg_menu

matlabbatch{2}.spm.temporal.st.scans{1}(1) = cfg_dep('File Selector (Batch Mode): Selected Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.spm.temporal.st.nslices = 64; %Number of slices per TR
matlabbatch{2}.spm.temporal.st.tr = 2; %TR (seconds)
matlabbatch{2}.spm.temporal.st.ta = 1.96875; %TA = TR - TR/N (where N = number of slices) 
matlabbatch{2}.spm.temporal.st.so = [0,942.500000000000,1882.50000001000,815,1757.50000001000,690,1632.50000001000,565,1505,440,1380,315,1255,190,1130,62.5000000000000,1005,1945.00000001000,880,1820.00000001000,752.500000000000,1695.00000001000,627.500000000000,1570.00000001000,502.500000000000,1442.50000000000,377.500000000000,1317.50000000000,252.500000000000,1192.50000000000,125,1067.50000000000,0,942.500000000000,1882.50000001000,815,1757.50000001000,690,1632.50000001000,565,1505,440,1380,315,1255,190,1130,62.5000000000000,1005,1945.00000001000,880,1820.00000001000,752.500000000000,1695.00000001000,627.500000000000,1570.00000001000,502.500000000000,1442.50000000000,377.500000000000,1317.50000000000,252.500000000000,1192.50000000000,125,1067.50000000000]; %slice order; descending: [N N-1 N-2 ... last slice]; ascending: [1 2 ... N] 
matlabbatch{2}.spm.temporal.st.refslice = 0; %Reference slice (usually the median slice number)
matlabbatch{2}.spm.temporal.st.prefix = 'a'; %Prefix of file outputs 


spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end



