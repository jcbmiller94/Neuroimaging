% Script to extract the parameters for building an Encoding Model
%
% J. Scimeca | jscimeca@berkeley.edu | December 2016
% For use with BCWM-fMRI project
%
mask_filename='Encode_SceneAndFaceSelective_VentralStream_combined';
total_trials=336; % total number of trials

%%% Load the binary mask of voxels we want to include
% These first two lines use SPM calls to open the NII file and pull out the binary image
mask_header = spm_vol(['../Cluster_ROIs/' mask_filename '.nii']);
mask_binary = spm_read_vols(mask_header); % binary mask should be in dimensions of the functional scan
mask_binary = round(mask_binary); % the 1 values in the mask output of imcalc is (sometimes?) a float close to 1


%%% Load the beta map for each individual trial and extract values for voxels included in mask
for beta_loop=1:total_trials
    % These two lines use SPM calls to open the NII file and pull out the Beta image
    betaMap_header = spm_vol(['../GLM_multivariate_combined/Conditions' num2str(beta_loop) '/beta_0001.nii']);
    betaMap_image = spm_read_vols(betaMap_header); % the betaMap_image should have the same dimensions as mask image
    
    % Check for dimension mismatch
    if sum((size(mask_binary)==size(betaMap_image))) ~= 3, error('ERROR: dimensions do not match!'), end

    % Pull the Beta values for the voxels indicated in the mask. Output will be in vector form.
    beta_vector = betaMap_image(mask_binary==1);
    
    % Put all the vectors into an array: each column is a trial; each row is the same voxel
    beta_array(:,beta_loop)=beta_vector;
    
    % clear some variables for safety
    clear betaMap_header betaMap_image beta_vector
end

% Clear voxels that are NaN
nan_array=isnan(beta_array); % find NaNs in beta_array
nan_index=sum(nan_array,2); % condense to a column vector indicating which rows have NaNs
beta_array=beta_array(nan_index==0,:); % only include voxels that have actual values (ie: not NaN) for all trials

% Save beta_array to a .mat file
save(['TrialwiseBetaArray_' mask_filename '_combined.mat'], 'beta_array');