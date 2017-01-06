%-----------------------------------------------------------------------
% PREPROCESSING SMOOTHING
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging)
%
% Use SPM's smoothing function on image data from the the BiCoWM task 
%
% TO CHECK FOR EACH USE: 
%  - Filter for selected files (e.g., '^ra')  
%  - Smoothing kernel size (e.g., [8 8 8]) FWHM in mm 
%
%-----------------------------------------------------------------------
function [matlabbatch] = job_smooth(b)

matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{1}]};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^ra';
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{2}.spm.spatial.smooth.data(1) = cfg_dep('File Selector (Batch Mode): Selected Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.spm.spatial.smooth.fwhm = [8 8 8]; %Size of Gaussian smoothing kernel 
matlabbatch{2}.spm.spatial.smooth.dtype = 0;
matlabbatch{2}.spm.spatial.smooth.im = 0;
matlabbatch{2}.spm.spatial.smooth.prefix = 's';

name = strcat(b.sess, '_smooth_batch.mat'); 
save(name, 'matlabbatch');

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end
