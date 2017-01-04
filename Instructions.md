###Instructions for executing analysis scripts for BiCoWM pipeline 

Data and derivatives layout: 

**jam124/BiCoWM:**
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
  * behav
    
  * derivatives_test 
  * raw 
