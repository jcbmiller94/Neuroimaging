%-----------------------------------------------------------------------
% Job saved on 15-Sep-2016 18:24:35 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
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

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end