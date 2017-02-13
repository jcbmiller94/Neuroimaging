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


%matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{1}]};
%matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^ra'; 
%matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{1}]};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^ar'; % session 1
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{2}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{2}]};
matlabbatch{2}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^ra'; % session 2
matlabbatch{2}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%motion = dir(fullfile(b.dataDir, b.funcRuns{1}, '*rp*.txt'))
%motionpath = strcat(b.dataDir, b.funcRuns{1},'/', motion.name())

% get paths for realignment parameter files from session 1 and 2 
motion = dir(fullfile(b.dataDir, b.funcRuns{1}, '*rp*.txt')); 
motionpath = strcat(b.dataDir, b.funcRuns{1},'/', motion.name()); 
motion2 = dir(fullfile(b.dataDir, b.funcRuns{2}, '*rp*.txt')); 
motion2path = strcat(b.dataDir, b.funcRuns{2}, '/', motion2.name()); 

% concatenate text files for RPs from both sessions using command line  
command_path = strcat({motionpath}, {' '}, {motion2path}, {' > motion_combined.txt'}); 
system(sprintf('cat %s', char(command_path))); 

matlabbatch{3}.spm.stats.fmri_spec.dir = {b.spmMatDir}; % '/home/despoB/jam124/BiCoWM/derivatives_test/s01/GLM_batched'
matlabbatch{3}.spm.stats.fmri_spec.timing.units = 'secs'; % timing in seconds for onsets
matlabbatch{3}.spm.stats.fmri_spec.timing.RT = 2; % TR (secs) 
matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t = 64; % # of slices per TR
matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t0 = 33; % number of reference slice
matlabbatch{3}.spm.stats.fmri_spec.sess.scans(1) = cfg_dep('File Selector (Batch Mode): Selected Files (ar)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{3}.spm.stats.fmri_spec.sess.scans(2) = cfg_dep('File Selector (Batch Mode): Selected Files (ra)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{3}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{3}.spm.stats.fmri_spec.sess.multi = {[b.conditions]}; % .mat file containing {names} {onsets} {durations}
matlabbatch{3}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{3}.spm.stats.fmri_spec.sess.multi_reg = {'motion_combined.txt'}; %i.e., '/home/despoB/jam124/BiCoWM/derivatives_test/s01/RawEPI/rp_sub-01_task-BiCoWM_bold_s006a001_001.txt'
matlabbatch{3}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{3}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{3}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0]; % time or dispersion derivatives?
matlabbatch{3}.spm.stats.fmri_spec.volt = 1;
matlabbatch{3}.spm.stats.fmri_spec.global = 'None';
matlabbatch{3}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{3}.spm.stats.fmri_spec.mask = {''};
matlabbatch{3}.spm.stats.fmri_spec.cvi = 'AR(1)';

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end