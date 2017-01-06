%-----------------------------------------------------------------------
% PREPROCESSING COREGISTRATION (ESTIMATION ONLY)
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging)
%
% Use SPM's coregistration function to estimate parameters for registration 
%
% TO CHECK FOR EACH USE: 
%  - sess_1_mean: location and filter for mean functional image of sess 1 
%  - sess_2_mean: location and filter for mean functional image of sess 2
%  - Filter for selected files (e.g., '^a')  
%
%-----------------------------------------------------------------------
function [matlabbatch] = job_coreg_estimate_reslice(b)

sess_1_mean = dir(fullfile(b.dataDir, b.funcSess1, '*mean*.nii'))
sess_1_mean_path = strcat(b.dataDir, b.funcSess1,'/', sess_1_mean.name(), ',1')

% matlabbatch{1}.spm.spatial.coreg.estimate.ref = {funcpath};

sess_2_mean = dir(fullfile(b.dataDir, b.funcRuns{1}, '*mean*.nii'))
sess_2_mean_path = strcat(b.dataDir, b.funcRuns{1},'/', sess_2_mean.name(), ',1')

% matlabbatch{1}.spm.spatial.coreg.estimate.source = {anatpath};

% matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};
% matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
% matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
% matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
% matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];

matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{1}]};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^a';
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

matlabbatch{2}.spm.spatial.coreg.estwrite.ref = {sess_1_mean_path};
matlabbatch{2}.spm.spatial.coreg.estwrite.source = {sess_2_mean_path};
matlabbatch{2}.spm.spatial.coreg.estwrite.other(1) = cfg_dep('File Selector (Batch Mode): Selected Files (^a)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.interp = 4;
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';

name = strcat(b.sess, '_coreg_est_res_batch.mat'); 
save(name, 'matlabbatch');

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end