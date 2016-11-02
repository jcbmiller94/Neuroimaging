%-----------------------------------------------------------------------
% Job saved on 15-Sep-2016 12:09:26 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
%-----------------------------------------------------------------------

function [matlabbatch] = job_coreg(b)
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{1}]}; % File Selector (Batch Mode): Directory - cfg_files;
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^means'; %MEAN of the realigned, slice-time corrected images%matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList'; % File Selector (Batch Mode): Do not descend into subdirectories - cfg_menu


matlabbatch{2}.spm.spatial.coreg.estimate.ref(1) = cfg_dep('File Selector (Batch Mode): Selected Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));

matlabbatch{2}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.anatT1]}; % File Selector (Batch Mode): Directory - cfg_files;
matlabbatch{2}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^s'; %Anatomical T1 scan (just one!!)
matlabbatch{2}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList'; % File Selector (Batch Mode): Do not descend into subdirectories - cfg_menu

matlabbatch{2}.spm.spatial.coreg.estimate.source(1) = cfg_dep('File Selector (Batch Mode): Selected Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.spm.spatial.coreg.estimate.other = {''};
matlabbatch{2}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{2}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
matlabbatch{2}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{2}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end
