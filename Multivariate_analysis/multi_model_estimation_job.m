%-----------------------------------------------------------------------
% Job saved on 19-Oct-2016 21:32:54 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6685)
%-----------------------------------------------------------------------
function [matlabbatch] = job_model_estimation(b)

matlabbatch{1}.spm.stats.fmri_est.spmmat = {b.spmMat};
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;


spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end