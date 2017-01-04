##Instructions for executing analysis scripts for BiCoWM pipeline 

Data and derivatives layout: 

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
        sub-01_task-BiCoWM_bold_s006a001_001.nii 
        rsub-01_task-BiCoWM_bold_s006a001_001.nii *realigned and resliced*
        arsub-01_task-BiCoWM_bold_s006a001_001.nii *slice-time corrected*
        sarsub-01_task-BiCoWM_bold_s006a001_001.nii *smoothed* 
      * Raw_EPI_Session2
        sub-01C_task-BiCoWM_bold_s006a001_001.nii 
        asub-01C_task-BiCoWM_bold_s006a001_001.nii *slice-time corrected*
        rasub-01C_task-BiCoWM_bold_s006a001_001.nii *coregistered and rescliced to sess 1 functional*
        srasub-01C_task-BiCoWM_bold_s006a001_001.nii *smoothed*
  * raw 
