%-----------------------------------------------------------------------
% CONTRAST MANAGER SETUP
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging)
%
% Use SPM's contrast manager to build contrasts of interest from the GLM
%  regressors
%
% TO CHECK FOR EACH USE: 
%  -  contrast names 
%
%-----------------------------------------------------------------------
function [matlabbatch] = job_contrast_manager(b)


matlabbatch{1}.spm.stats.con.spmmat = {b.spmMat};
matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'Encode: all (E1-E5) > fixation';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [1 1 1 1 1 0 0 0 0 0 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'Encode: faces (E1 E4) > scenes (E2 E5)';
matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = [1 -1 0 1 -1 0 0 0 0 0 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'Encode: scenes (E2 E5) > faces (E1 E4)';
matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = [-1 1 0 -1 1 0 0 0 0 0 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'Delay: load 4 - faces (D1)';
matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'Delay: load 4 - scenes (D2)';
matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights = [0 0 0 0 0 0 1 0 0 0 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = 'Delay: load 4 - mixed (D3)';
matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights = [0 0 0 0 0 0 0 1 0 0 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{7}.tcon.name = 'Delay: load 2 - faces (D4)';
matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights = [0 0 0 0 0 0 0 0 1 0 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{8}.tcon.name = 'Delay: load 2 - scenes (D5)';
matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights = [0 0 0 0 0 0 0 0 0 1 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{8}.tcon.name = 'Delay: load 4 - all (D1 D2 D3) > load 2 - all (D4 D5)';
matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights = [0 0 0 0 0 2 2 2 -3 -3 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.delete = 0;

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end