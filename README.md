Automatic IHI Rating
====================

# Abstract 
Incomplete Hippocampal Inversion (IHI), sometimes called hippocampal malrotation, is an atypical anatomical pattern of the hippocampus found in about 20\% of the general population.  IHI can be visually assessed on coronal slices of T1 weighted MR images, using a composite score that combines four anatomical criteria.
IHI has been associated with several brain disorders (epilepsy, schizophrenia). However, these studies were based on small samples. Furthermore, the factors (genetic or environmental) that contribute to the genesis of IHI are largely unknown. Large-scale studies are thus needed to further understand IHI and their potential relationships to neurological and psychiatric disorders.
However, visual evaluation is long and tedious, justifying the need for an automatic method.  
In this paper, we propose, for the first time, to automatically rate IHI. We proceed by predicting four anatomical criteria, which are then summed up to form the IHI score, providing the advantage of an interpretable score. We provided an extensive experimental investigation of different machine learning methods and training strategies. We performed automatic rating using a variety of deep learning models ("conv5-FC3", ResNet and "SECNN") as well as a ridge regression. We studied the generalization of our models using different cohorts and performed multi-cohort learning. We relied on a large population of 2,008 participants from the IMAGEN study, 993 and 403 participants from the QTIM and QTAB studies as well as 985 subjects from the UKBiobank. All trained models performed better than chance. We showed that deep learning models outperformed a ridge regression. We demonstrated that the performances of the "Conv5-FC3" network were at least as good as more complex networks while maintaining a low complexity and computation time. We showed that training on a single cohort may lack in variability while training on several cohorts improves generalization (acceptable performances on all tested cohorts including some that are not included in training). The models trained on the IMAGEN, QTIM and QTAB cohorts is available in this repository. 

# Main Contributors 
- [Lisa Hemforth](https://github.com/LisaHemforth)
- [Alexandre Martin](https://github.com/Raelag0112)
- [Camille Brinceau](https://github.com/camillebrianceau)
- [Matthieu Joulot](https://github.com/MatthieuJoulot)
- [Baptiste Couvy-Duchesne](https://github.com/baptisteCD)
- [Claire Cury](https://github.com/cclairec)
- [Olivier Colliot](https://github.com/oliviercolliot)

# Repository Structure 
The respository is structured as follows: 
``` bash
├── README.md
├── trained_models
    ├── IMAGEN
        ├── CNN
        ├── ResNet
        ├── SECNN
    ├── IMAGEN_QTIM_QTAB
        ├── CNN
        ├── ResNet
        ├── SECNN
    ├── IMAGEN_QTIM_QTAB_UKB
        ├── CNN
        ├── ResNet
        ├── SECNN
├── results
├── scripts
    ├── pre-processing
    ├── prediction
```

The data for this study can unfortunately not be made accessible. However, the pre-rained models are available in the `trained_models` folder. The models were trained with clinicaDL (https://clinicadl.readthedocs.io/en/latest/Train/Introduction/). Users should hence get familiar with this training strategy. Trained models can be found in the subfolders corresponding to training_methods (`IMAGEN`, `IMAGEN_QTIM_QTAB`,`IMAGEN_QTIM_QTAB_UKB`)  and model (`CNN`, `ResNet`, `SECNN`). We advise using the "conv5-FC3" trained on the IMAGEN, QTIM and QTAB data-sets. While we cannot disclose individual results, the figures of the paper showing the summarry statistics obtained with each model can be found in the `results` folder. The scripts to predict further results can be found in the `scripts` folder along with the pre-processing pipeline. 

# Usage
Fork this github directory and ensure you are connect to your own github through ssh using this tutorial : https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=mac
You can now clone the repository. Another option is to simply download the zip file.
```
git clone git@github.com:Linktoyourgithub
```
If you want to create your own environment or are not operating under linux:
```
#Linux
conda env create -n IHIRating python==3.9
#Apple
conda create --name IHIRating python==3.9 -c conda-forge
```
Then install clinica and clinicadl:
```
conda activate IHIRating
pip install clinica
pip install clinicadl==1.1.1
```
Or simply create an environment with the IHIrating.yml file found in scripts. This method will only work if you are operating under Linux.
```
cd scripts
conda env create -f IHIRating.yml
conda activate IHIRating
```
Check that your clinicadl version is 1.1.1
```
clinicadl --version
```
Clinica also requires spm. If you already have SPM standalone or SPM and matlab you can skip this step. SPM is based on MATLAB, however, a standalone version is available which only requires MATLAB runtime (download the 2022a version here and follow the installer https://fr.mathworks.com/products/compiler/matlab-runtime.html). If you are using linux: 
```
cd /path/to/your/Matlab_runntime
unzip MATLAB_Runtime_R2022a_Update_7_glnxa64.zip
cd MATLAB_Runtime_R2022a_Update_7_glnxa64
chmod 755 install
./install
```
Install MATLAB in your home/MATLAB directory. You can download spm standalone at the following link (please ensure to use the 2022a version) : https://fr.mathworks.com/products/compiler/matlab-runtime.html . Unzip your file. You can check that spm works using the following command.
```
cd path/to/your/spm
./run_spm12.sh /home/MATLAB/v912
export SPMSTANDALONE_HOME=/path/to/your/spm
export MCR_HOME=/home/MATLAB/v912
```
If your already have SPM and MATLAB set the SPM_HOME to your SPM folder.
You can then use the clinica T1-volume pipeline for pre-processing. Make sure that your data is in bids format. Indicate the CAPS directory where you want to store your processed data as well as a tsv file containing the column 'participant_id' and 'session_id' indicating which participants and sessions to process, as well as a column 'diagnosis' with the word 'train' on every row. This last column should not be necessary anymore in the future updates. 
```
clinica run t1-volume-tissue-segmentation BIDS_DIRECTORY CAPS_DIRECTORY -tsv TSV_FILE
```
You then extract tensors from the greymatter maps which will be used for prediction using the previously defined ROI mask. The file for this mask can be found in the pre-processing directory. Make sure to copy this file into CAPS_DIRECTORY/masks/tpl-MNI152NLin2009cSym. We use a cutsom suffix to ensure the use of greymatter maps for tensor extraction. 
```
clinicadl extract roi CAPS_DIRECTORY custom --custom_suffix normalized_space/*graymatter_space-Ixi549Space_modulated-off_probability.nii.gz --roi_custom_template MNI152NLin2009cSym --roi_list hippvol --subjects_sessions_tsv TSV_FILE --save_features --extract_json hippGM.json  --roi_uncrop_output
```
You can now start the predicition using our models. Download the trained_models folder and choose which model you want to apply to your data. We recommend using the Conv5-FC3 trained on IMAGEN,QTIM,QTAB. You can then launch the prediction using the following command. Criteria can either be predicted indivually or the composite score can be predicted directly. In the former case, predicted results will then need to be added together to obtain the full IHI score. The INPUT_MAPS DIRECTORY needs to be a path to the pretrained models MAPS (ex: trained_models/IMAGEN_QTIM_QTAB/Conv5-FC3/MAPS_C1_L). Define you data group name to recognise your predictions later on. 
```
for crit in C1_L C1_R C2_L C2_R C3_L C3_R C5_L C5_R SCi_L SCi_R
do
    clinicadl predict MAPS_DIRECTORY_${crit} DATA_GROUP --caps_directory CAPS_DIRECTORY --participants_tsv TSV_FILE --no_labels --overwrite --no-gpu
done
```
You should now see your results in the MAPS_DIRECTORY as MAPS_DIRECTORY/split-0/best-loss/DATA_GROUP/DATA_GROUP_roi_level_predictions.tsv

# Requirements
- Python >= 3.8
- [ClinicaDL](https://clinicadl.readthedocs.io/en/latest/Train/Introduction/)
- [Clinica](https://aramislab.paris.inria.fr/clinica/docs/public/latest/)
- SPM
- MATLAB runntime
