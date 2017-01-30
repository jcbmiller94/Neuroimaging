%-----------------------------------------------------------------------
% UNIVARIATE RESULTS
%   Jacob Miller, 12/20/16 (https://github.com/jcbmiller94/Neuroimaging)
%
% Use SPM's results to threshold, display, and save maps 
%
% TO CHECK FOR EACH USE: 
%  - thresh: uncorrected p value threshold 
%  - extent: treshold for cluster size
%
%-----------------------------------------------------------------------
function [matlabbatch] = job_results(b)


matlabbatch{1}.spm.stats.results.spmmat = {b.spmMat};
matlabbatch{1}.spm.stats.results.conspec.titlestr = '';
matlabbatch{1}.spm.stats.results.conspec.contrasts = Inf;
matlabbatch{1}.spm.stats.results.conspec.threshdesc = 'none';
matlabbatch{1}.spm.stats.results.conspec.thresh = 0.001; % uncorrected p value threshold
matlabbatch{1}.spm.stats.results.conspec.extent = 15;% extent threshold, 15 voxels
matlabbatch{1}.spm.stats.results.conspec.conjunction = 1;
matlabbatch{1}.spm.stats.results.conspec.mask.none = 1;
matlabbatch{1}.spm.stats.results.units = 1;
matlabbatch{1}.spm.stats.results.print = 'pdf';
matlabbatch{1}.spm.stats.results.write.none = 1;

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end
