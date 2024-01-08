# Criteria can either be predicted indivually or the composite score can be predicted directly. In the former case, predicted results will then need to be added together to obtain the full IHI score.
# The INPUT_MAPS DIRECTORY needs to be a path to the pretrained model.

for crit in C1_L C1_R C2_L C2_R C3_L C3_R C5_L C5_R
do
    clinicadl predict INPUT_MAPS_DIRECTORY_${crit} DATA_GROUP --caps_directory CAPS_DIRECTORY --participants_tsv TSV_FILE --label ${crit} --overwrite
done