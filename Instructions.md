##Instructions for executing analysis scripts for BiCoWM pipeline 

### I. Data and derivatives layout: 
####jam124/BiCoWM:
  * batch_scripts (folder for this repository of scripts)  
    * `Get_onset_times.py` *extract onset times from behavioral output file* 
    * Preprocessing
      * `batch_preproc.m` *run preprocessing for session 1 of fMRI data* 
        * `initialize_vars.m`
        * `realign_job.m` 
        * `slice_timing_job.m`
        * `coreg_job_alt.m`
        * `smooth_job.m` 
    * Preprocessing_session2
      * `batch_preproc.m` *run preprocessing for session 2 of fMRI data* 
        * `initialize_vars.m`
        * `realign_estimate_only_job.m` 
        * `slice_timing_job.m`
        * `coreg_estimate_reslice_job.m`
        * `smooth_job.m` 
    * First-level analysis 
    * Multivariate_analysis
    
  * behav 
    * behavioral data (.txt files) 
  * derivatives_test 
    * s01 (subject #s) 
      * RawEPI 
        * sub-01_task-BiCoWM_bold_s006a001_001.nii ... 
      * Raw_EPI_Session2
        * sub-01C_task-BiCoWM_bold_s006a001_001.nii ... 
  * raw 
   * Raw DICOM data from scanner 

### II. Instructions for running preprocessing

(1) Ensure data is in format specified above. Raw .nii do not need the exact naming system above, but these are in line with the BIDS format. Image files must start with an 's' or the filter changed in the preprocessing scripts 

(2) Extract slice timing information from the DICOM. This can be done in SPM (from Siemens DICOMs) with the following commands
``` 
hdr = spm_dicom_headers('dicom.ima');
slice_times = hdr{1}.Private_0019_1029 
``` 

(3) Specify the preprocessing steps in the `batch_preproc.m` file for the given session and ensure the filepaths refer to the correct data locations. More detailed instructions are in the file header.

(4) Look through the header of each script specified above in the preprocessing folder for the given session. Ensure the filters, relative filepaths, and settings are specified correctly. 

(5) Finally, from the Matlab command window: `run batch_preproc.m`. Matlabbatch files for each preprocessing step will be saved under the subject ID in the derivatives_test folder 

### III. Instructions for running univariate analysis across sessions (within-subject)
