This Github repository contains the scripts used in Chapter 4 of Alejandro De Los Angeles's DPhil thesis. The main bioinformatics tool that was used was TOBIAS, which is used for transcription factor footprinting of chromatin accessibility data. Additionally a script for basic statistical analysis of BrainSpan Developmental Transcriptome Data is provided.

The code for pre-processing of ATAC-seq data is contained in the "atac_preprocessing.sh" script. 

The code for in-house application of TOBIAS is contained in the "embryo.sh", "oct4.sh", "naive-formative.sh", and "hipsci.sh" scripts. The "embryo.sh" script was used to replicate the figures in the original TOBIAS paper (Bentsen et al, 2022). The "oct4.sh" and "naive-formative.sh" scripts were used to assess the sensitivity and specificity of TOBIAS in published mouse pluripotent stem cell ATAC-seq data (Yang et al, 2019; Xiong et al, 2022). Finally, the "hipsci.sh" script contains the code that waas used to conduct TF footprinting of hiPSC-derived neurons from the HIPSCI (Schwartzentruber et al, 2018).

The code for the chi-square test comparing TF footprint frequency at VGCC loci versus in randomly selected genes is featured in the "chisquare.R" script. The statistical analysis is carried out in R.

Additionally code for basic statistical analysis of BrainSpan Developmental Transcriptome Data is provided in the "brainspan_stats.R" and "brainspan_stats2.R" scripts. The scripts involve checking if a dataset is normally distributed using the Shapiro-Wilk test. They calculates median, interquartile range, and provides code for conducting a Mann-Whitney U test to test for differences. "brainspan_stats.R" script contains code for comparing fetal versus postnatal stamples whereas "brainspan_stats2.R" script contains code for comparing early versus late fetal stage samples.

References

Bentsen M, et al. ATAC-seq footprinting unravels kinetics of transcription factor binding during zygotic genome activation. Nature Communications 11: 4267 (2020).

Schwartzentruber et al. Molecular and functional variation in iPSC-derived sensory neurons. Nature Genetics 50: 54 - 61 (2018).

Xiong L, et al. Oct4 differentially regulates chromatin opening and enhancer transcription in pluripotent stem cells. Elife 11:e71533 (2022).

Yang S-H, et al. ZIC3 controls the transition from naive to primed pluripotency. Cell Reports 27: 3215 - 3227 (2019).

Contact: Alejandro De Los Angeles (adelosan@gmail.com)
