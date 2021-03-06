%-----------------------------------------------------------------------
% Job saved on 19-Oct-2016 20:56:12 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6685)
%-----------------------------------------------------------------------
function [matlabbatch] = job_model_specification(b)


matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{1}]};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^sar';
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

motion = dir(fullfile(b.dataDir, b.funcRuns{1}, '*rp*.txt'))
motionpath = strcat(b.dataDir, b.funcRuns{1},'/', motion.name())

matlabbatch{2}.spm.stats.fmri_spec.dir = {b.spmDir}; %'/home/despoB/jam124/BiCoWM/derivatives_test/s01/GLM_batched'
matlabbatch{2}.spm.stats.fmri_spec.timing.units = 'secs'; %timing in seconds for onsets
matlabbatch{2}.spm.stats.fmri_spec.timing.RT = 2; %TR (secs) 
matlabbatch{2}.spm.stats.fmri_spec.timing.fmri_t = 64; %# of slices per TR
matlabbatch{2}.spm.stats.fmri_spec.timing.fmri_t0 = 33; %number of reference slice
matlabbatch{2}.spm.stats.fmri_spec.sess.scans(1) = cfg_dep('File Selector (Batch Mode): Selected Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.multi = {'/home/despoB/jam124/BiCoWM/derivatives_test/s01/GLM_by_trial_type/Conditions.mat'}; %mat file containing {names} {onsets} {durations}
matlabbatch{2}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.multi_reg = {motionpath}; %i.e., '/home/despoB/jam124/BiCoWM/derivatives_test/s01/RawEPI/rp_sub-01_task-BiCoWM_bold_s006a001_001.txt'
matlabbatch{2}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{2}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{2}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0]; %time or dispersion derivatives?
matlabbatch{2}.spm.stats.fmri_spec.volt = 1;
matlabbatch{2}.spm.stats.fmri_spec.global = 'None';
matlabbatch{2}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{2}.spm.stats.fmri_spec.mask = {''};
matlabbatch{2}.spm.stats.fmri_spec.cvi = 'AR(1)';

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end