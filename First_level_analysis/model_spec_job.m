%-----------------------------------------------------------------------
% Job saved on 22-Sep-2016 16:53:51 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
%-----------------------------------------------------------------------

function [matlabbatch] = job_model_spec(b)



matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{1}]}; % File Selector (Batch Mode): Directory - cfg_files
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^sar'; % File Selector (Batch Mode): Filter - cfg_entry, start of filenames (i.e. '^s') 
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList'; % File Selector (Batch Mode): Do not descend into subdirectories - cfg_menu

matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_mkdir.parent = cellstr(data_path);
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_mkdir.name = 'categorical';

matlabbatch{1}.spm.stats.fmri_spec.dir = {'/home/despoB/jam124/1SPM_Practice_Data/face_rep/Data/categorical'}; %Directory where design matrix is written
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'scans'; %scans or seconds
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 64;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 34;  %reference slice from slice-timing correction

onsets    = load(fullfile(b.behavDir,'SOTS.mat'));
condnames = {'L4:F' 'L4:S' 'L4:F+S' 'L2:F' 'L2:S'};


matlabbatch{1}.spm.stats.fmri_spec.sess.scans = '<UNDEFINED>';

for i=1:numel(condnames)
    matlabbatch{2}.spm.stats.fmri_spec.sess.cond(i).name = condnames{i};
    matlabbatch{2}.spm.stats.fmri_spec.sess.cond(i).onset = onsets.sot{i};
    matlabbatch{2}.spm.stats.fmri_spec.sess.cond(i).duration = 0;
end

matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).name = 'L4:F'; %Name of condition 1
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).onset = []; %stimulus onset times of this condition (in seconds) 
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).duration = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {}); %parametric modulators
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).orth = 1; %orthogonal modulators

matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).name = 'L4:S'; %Name of condition 2
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).onset = [];
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).duration = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).name = 'L4:F+S'; %Name of condition 3
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).onset = [];
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).duration = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).name = 'L2:F';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).onset = [];
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).duration = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess.cond(5).name = 'L2:S';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(5).onset = [];
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(5).duration = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(5).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(5).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(5).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {'/home/despoB/jam124/SPM_Practice_Data/face_rep/RawEPI/rp_sM03953_0005_0006.txt'}; %file for motion parameters 
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;

matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [1 1];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end
