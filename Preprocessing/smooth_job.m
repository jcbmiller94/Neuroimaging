%-----------------------------------------------------------------------
% Job saved on 15-Sep-2016 17:04:47 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
%-----------------------------------------------------------------------
function [matlabbatch] = job_smooth(b)

matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{1}]};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^ar';
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{2}.spm.spatial.smooth.data(1) = cfg_dep('File Selector (Batch Mode): Selected Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.spm.spatial.smooth.fwhm = [8 8 8]; %Size of Gaussian smoothing kernel 
matlabbatch{2}.spm.spatial.smooth.dtype = 0;
matlabbatch{2}.spm.spatial.smooth.im = 0;
matlabbatch{2}.spm.spatial.smooth.prefix = 's';

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end
