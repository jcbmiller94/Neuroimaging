%-----------------------------------------------------------------------
% MULTIVARIATE MODEL SPECIFICATION
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging) 
%
% Using matlabbatch and spm_jobman
%
% Notes:
% - uses preprocessed, but unsmoothed .nii files 
% - assumed relaignment parameters starting with 'rp' and ending in '.txt'
% are save in same location as the EPI files 

% TO CHANGE FOR EACH USE:
% - filter (e.g. '^ra') - change depending on prefixes of your unsmoothed
%  files, and order of preprocessing 
% - slice timing info: TR, # of slices / TR, reference slice # (see below) 
% - time/disperision derivatives, masking threshold (see below) 
%-----------------------------------------------------------------------
function [matlabbatch] = job_model_specification(b)


matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{1}]};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^ra'; 
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

motion = dir(fullfile(b.dataDir, b.funcRuns{1}, '*rp*.txt'))
motionpath = strcat(b.dataDir, b.funcRuns{1},'/', motion.name())

matlabbatch{2}.spm.stats.fmri_spec.dir = {b.spmMatDir}; %'/home/despoB/jam124/BiCoWM/derivatives_test/s01/GLM_batched'
matlabbatch{2}.spm.stats.fmri_spec.timing.units = 'secs'; %timing in seconds for onsets
matlabbatch{2}.spm.stats.fmri_spec.timing.RT = 2; %TR (secs) 
matlabbatch{2}.spm.stats.fmri_spec.timing.fmri_t = 64; %# of slices per TR
matlabbatch{2}.spm.stats.fmri_spec.timing.fmri_t0 = 33; %number of reference slice
matlabbatch{2}.spm.stats.fmri_spec.sess.scans(1) = cfg_dep('File Selector (Batch Mode): Selected Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.multi = {b.conditions}; %mat file containing {names} {onsets} {durations}
matlabbatch{2}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.multi_reg = {motionpath}; %i.e., '/home/despoB/jam124/BiCoWM/derivatives_test/s01/RawEPI/rp_sub-01_task-BiCoWM_bold_s006a001_001.txt'
matlabbatch{2}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{2}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{2}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0]; %time or dispersion derivatives? ([0 0] for none)
matlabbatch{2}.spm.stats.fmri_spec.volt = 1;
matlabbatch{2}.spm.stats.fmri_spec.global = 'None';
matlabbatch{2}.spm.stats.fmri_spec.mthresh = 0.8; % masking threshold for voxel intensity (default = 0.8)
matlabbatch{2}.spm.stats.fmri_spec.mask = {''};
matlabbatch{2}.spm.stats.fmri_spec.cvi = 'AR(1)';

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end