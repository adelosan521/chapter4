This Github repository contains the scripts used in Chapter 4 of Alejandro De Los Angeles's DPhil thesis. The main bioinformatics tool that was used was TOBIAS. Additionally a script for basic statistical analysis of BrainSpan Developmental Transcriptome Data is provided.

The code for pre-processing of ATAC-seq data is contained in the "atac_preprocessing" script. 

The code for in-house application of TOBIAS is contained in the "embryo", "oct4", "naive-formative", and "hipsci" scripts. The "embryo" script was used to replicate the figures in the original TOBIAS paper (Bentsen et al, 2022). The "oct4" and "naive-formative" scripts were used to assess the sensitivity and specificity of TOBIAS in published mouse pluripotent stem cell ATAC-seq data (Yang et al, 2019; Xiong et al, 2022). Finally, the "hipsci" script contains the code that waas used to conduct TF footprinting of hiPSC-derived neurons from the HIPSCI (Schwartzentruber et al, 2018).

The code for statistical analysis of BrainSpan Developmental Transcriptome data is in the "brainspan_stats" script. The statistical analysis is carried out in R and involves calculation of mean, standard error, and carrying out a t-test to compare two sets of samples.

References

Bentsen M, et al. ATAC-seq footprinting unravels kinetics of transcription factor binding during zygotic genome activation. Nature Communications 11: 4267 (2020).

Schwartzentruber et al. Molecular and functional variation in iPSC-derived sensory neurons. Nature Genetics 50: 54 - 61 (2018).

Xiong L, et al. Oct4 differentially regulates chromatin opening and enhancer transcription in pluripotent stem cells. Elife 11:e71533 (2022).

Yang S-H, et al. ZIC3 controls the transition from naive to primed pluripotency. Cell Reports 27: 3215 - 3227 (2019).

Contact: Alejandro De Los Angeles (adelosan@gmail.com)
