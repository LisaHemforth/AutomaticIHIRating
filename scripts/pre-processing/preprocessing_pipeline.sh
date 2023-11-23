# The following scripts outlines the preprocessing steps for images to be used for automatic IHI prediction.
# The first step is to use the clinica T1-volume processing step. Make sure your data is in the BIDS format. 
clinica run t1-volumee BIDS_DIRECTORY CAPS_DIRECTORY GROUP_LABEL -tsv TSV_FILE -wd WORKIN_DIRECTORY

# We then extract the tensors from the greymatter maps which will be used for prediction using the previously defined ROI mask. The file for this mask can be found in this directory. 
clinicadl extract roi CAPS_DIRECTORY custom --custom_suffix normalized_space/*graymatter_space-Ixi549Space_modulated-off_probability.nii.gz --roi_custom_template MNI152NLin2009cSym --roi_list hippvol --subjects_sessions_tsv TSV_FILE --save_features --extract_json hippGM.json  --roi_uncrop_output
