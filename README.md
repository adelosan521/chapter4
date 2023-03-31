This Github repository contains the scripts used in Chapter 4 of Alejandro De Los Angeles's DPhil thesis. The main bioinformatics tool that was used was TOBIAS. Additionally a script for basic statistical analysis of BrainSpan Developmental Transcriptome Data is provided.

The code for pre-processing of ATAC-seq data is contained in the "atac_preprocessing" script. 

The code for in-house application of TOBIAS is contained in the "embryo", "oct4", "naive-formative", and "hipsci" scripts. The "embryo" script was used to replicate the figures in the original TOBIAS paper (Bentsen et al, 2022). The "oct4" and "naive-formative" scripts were used to assess the sensitivity and specificity of TOBIAS in published mouse pluripotent stem cell ATAC-seq data. Finally, the "hipsci" script contains the code that waas used to conduct TF footprinting of hiPSC-derived neurons from the HIPSCI.

The code for statistical analysis of BrainSpan Developmental Transcriptome data is in the "brainspan_stats" script. The statistical analysis is carried out in R and involves calculation of mean, standard error, and carrying out a t-test to compare two datasets.
