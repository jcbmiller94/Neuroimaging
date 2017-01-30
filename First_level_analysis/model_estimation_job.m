%-----------------------------------------------------------------------
% UNIVARIATE MODEL ESTIMATION
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging)
%
% Use SPM's model estimation function to calculate regressor weights (B) from the GLM 
%
% TO CHECK FOR EACH USE: 
%  -  
%
%-----------------------------------------------------------------------
function [matlabbatch] = job_model_estimation(b)

matlabbatch{1}.spm.stats.fmri_est.spmmat = {b.spmMat};
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;


spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end