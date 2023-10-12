Automatic IHI Rating
====================

# Abstratct 
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

The data for this study can unfortunately not be made accessible. However, the pre-rained models are available in the `trained_models` folder. The models were trained with clinicaDL (https://clinicadl.readthedocs.io/en/latest/Train/Introduction/). Users should hence get familiar with this training strategy. Trained models can be found in the subfolders corresponding to training_mehtods (`IMAGEN`, `IMAGEN_QTIM_QTAB`,`IMAGEN_QTIM_QTAB_UKB`)  and model (`CNN`, `ResNet`, `SECNN`). We advise using the "conv5-FC3" trained on the IMAGEN, QTIM and QTAB data-sets. While we cannot disclose individual results, the figures of the paper showing the summarry statistics obtained with each model can be found in the `results` folder. The scripts to predict further results can be found in the `scripts` folder along with the pre-processing pipeline. 

# Requirements
- Python >= 3.6
- [ClinicaDL](https://clinicadl.readthedocs.io/en/latest/Train/Introduction/)
- [Clinica](https://aramislab.paris.inria.fr/clinica/docs/public/latest/)
