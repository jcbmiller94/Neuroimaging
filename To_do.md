## To-do for BiCoWM pipeline 

1) Integration of new trial types:
  - **L2** => faces, bodies, scenes; **L4** => faces, bodies, scences; **L4 mixed** => faces:bodies, faces:scenes, bodies:scences
  
  - Correct/incorrect responses: will these be included in script output? To automatically handle these regressors more easily 
    - Can SPM take regressors with no weights? Otherwise, can build so that only conditions with any incorrect responses will be added...
    
  
2) Univariate GLMs for each subject separated by scanning session (in addition to combined GLM) 

3) Artifact detection pipeline integration: http://www.fil.ion.ucl.ac.uk/spm/ext/#TSDiffAna

4) Forward encoding model: re-adding NaNs back in after calculation, to project weights back into interpretable voxel space 

5) Contrast manager script for regressor weights - what was wanted here? Function to generate these vectors for an array of inputs? (because incorrect trial types will change, etc.) 
- get info from SPM.mat ==> XX file (from column names) 


Types of blocks: 
- All L2 (face/body/scene)
- body/face (L4 body,L4 face, L4 mixed body face)
- body/scene
- face/scene 

- get numbering for trial types (come up with something: L2 ==> L4 same ==> L4 mixed) 

  - 1: L2 face
  - 2: L2 body
  - 3: L2 scene
  - 4: L4 face
  - 5: L4 body
  - 6: L4 scene
  - 7: L4 mixed (face/body) 
  - 8: L4 mixed (face/scene)
  - 9: L4 mixed (body/scene) 
