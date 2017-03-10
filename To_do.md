## To-do for BiCoWM pipeline 

1) Integration of new trial types:
  - **L2** => faces, bodies, scenes; **L4** => faces, bodies, scences; **L4 mixed** => faces:bodies, faces:scenes, bodies:scences
  
  - Correct/incorrect responses: will these be included in script output? To automatically handle these regressors more easily 
  
2) Univariate GLMs for each subject separated by scanning session (in addition to combined GLM) 

3) Artifact detection pipeline integration: http://www.fil.ion.ucl.ac.uk/spm/ext/#TSDiffAna

4) Forward encoding model: re-adding NaNs back in after calculation, to project weights back into interpretable voxel space 
