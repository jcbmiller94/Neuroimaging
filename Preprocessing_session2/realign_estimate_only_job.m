%-----------------------------------------------------------------------
% PREPROCESSING REALIGNMENT (ESTIMATE ONLY)
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging)
%
% Use SPM's realignment unctions on data from the the BiCoWM task (but no 
%   reslicing until the registration step 
%
% TO CHECK FOR EACH USE: 
%  - Filter for selected files (e.g., '^s')  
%
%-----------------------------------------------------------------------

function [matlabbatch] = job_realign_estimate(b) %Realign: Estimate & Reslice 

matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[b.dataDir b.funcRuns{1}]}; % File Selector (Batch Mode): Directory - cfg_files
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^s'; % File Selector (Batch Mode): Filter - cfg_entry, start of filenames (i.e. '^s') 
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList'; % File Selector (Batch Mode): Do not descend into subdirectories - cfg_menu

matlabbatch{2}.spm.spatial.realign.estwrite.data{1}(1) = cfg_dep('File Selector (Batch Mode): Selected Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.spm.spatial.realign.estwrite.eoptions.quality = 0.9; % quality vs speed tradeoff, default = 0.9
matlabbatch{2}.spm.spatial.realign.estwrite.eoptions.sep = 4; % separation between points sampled, default = 4mm
matlabbatch{2}.spm.spatial.realign.estwrite.eoptions.fwhm = 5; % Gaussian smoothing kernel size, default = 5mm
matlabbatch{2}.spm.spatial.realign.estwrite.eoptions.rtm = 1; % Realign to mean (1) or first (0) image 
matlabbatch{2}.spm.spatial.realign.estwrite.eoptions.interp = 2; % Degree of interpolation, default = 2
matlabbatch{2}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0]; % Wrapping, Default = [0 0 0]
matlabbatch{2}.spm.spatial.realign.estwrite.eoptions.weight = '';
matlabbatch{2}.spm.spatial.realign.estwrite.roptions.which = [0 1]; % reslice the MEAN image only, not all images
matlabbatch{2}.spm.spatial.realign.estwrite.roptions.interp = 4;
matlabbatch{2}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{2}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{2}.spm.spatial.realign.estwrite.roptions.prefix = 'r'; % Filename prefix

name = strcat(b.sess, '_realign_batch.mat'); 
save(name, 'matlabbatch');

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end