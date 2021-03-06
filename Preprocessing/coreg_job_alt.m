%-----------------------------------------------------------------------
% PREPROCESSING COREGISTRATION (ESTIMATION ONLY)
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging)
%
% Use SPM's coregistration function to estimate parameters for registration 
%
% TO CHECK FOR EACH USE: 
%  - func: location and filter for mean functional image 
%  - anat: location and filter for subject anatomical 
%
%-----------------------------------------------------------------------
function [matlabbatch] = job_coreg_alt(b)

func = dir(fullfile(b.dataDir, b.funcRuns{1}, '*means*.nii'))
funcpath = strcat(b.dataDir, b.funcRuns{1},'/', func.name(), ',1')

matlabbatch{1}.spm.spatial.coreg.estimate.ref = {funcpath};

anat = dir(fullfile(b.dataDir, b.anatT1, '*s*.nii'))
anatpath = strcat(b.dataDir, b.anatT1,'/', anat.name(), ',1')

matlabbatch{1}.spm.spatial.coreg.estimate.source = {anatpath};

matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];

name = strcat(b.sess, '_coreg_est_batch.mat'); 
save(name, 'matlabbatch');

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end