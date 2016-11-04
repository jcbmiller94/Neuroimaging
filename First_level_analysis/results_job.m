%-----------------------------------------------------------------------
% Job saved on 19-Oct-2016 22:30:35 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6685)
%-----------------------------------------------------------------------
function [matlabbatch] = job_contrast_manager(b)


matlabbatch{1}.spm.stats.results.spmmat = {b.spmMat};
matlabbatch{1}.spm.stats.results.conspec.titlestr = '';
matlabbatch{1}.spm.stats.results.conspec.contrasts = Inf;
matlabbatch{1}.spm.stats.results.conspec.threshdesc = 'none';
matlabbatch{1}.spm.stats.results.conspec.thresh = 0.001;
matlabbatch{1}.spm.stats.results.conspec.extent = 15;
matlabbatch{1}.spm.stats.results.conspec.conjunction = 1;
matlabbatch{1}.spm.stats.results.conspec.mask.none = 1;
matlabbatch{1}.spm.stats.results.units = 1;
matlabbatch{1}.spm.stats.results.print = 'pdf';
matlabbatch{1}.spm.stats.results.write.none = 1;

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end
