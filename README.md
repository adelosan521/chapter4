This Github repository contains the scripts used in Chapter 4 of Alejandro De Los Angeles's DPhil thesis. The main bioinformatics tool that was used was TOBIAS, which is used for transcription factor footprinting of chromatin accessibility data. Additionally a script for basic statistical analysis of BrainSpan Developmental Transcriptome Data is provided.

The code for pre-processing of ATAC-seq data is contained in the "atac_preprocessing.sh" script. 

The code for in-house application of TOBIAS is contained in the "embryo.sh", "oct4.sh", "naive-formative.sh", and "hipsci.sh" scripts. The "embryo.sh" script was used to replicate the figures in the original TOBIAS paper (Bentsen et al, 2022). The "oct4.sh" and "naive-formative.sh" scripts were used to assess the sensitivity and specificity of TOBIAS in published mouse pluripotent stem cell ATAC-seq data (Yang et al, 2019; Xiong et al, 2022). Finally, the "hipsci.sh" script contains the code that waas used to conduct TF footprinting of hiPSC-derived neurons from the HIPSCI (Schwartzentruber et al, 2018).

The code for statistical analysis of BrainSpan Developmental Transcriptome data is in the "brainspan_stats.R" script. The statistical analysis is carried out in R and involves calculation of mean, standard error, and carrying out a t-test to compare two sets of samples.

References

Bentsen M, et al. ATAC-seq footprinting unravels kinetics of transcription factor binding during zygotic genome activation. Nature Communications 11: 4267 (2020).

Schwartzentruber et al. Molecular and functional variation in iPSC-derived sensory neurons. Nature Genetics 50: 54 - 61 (2018).

Xiong L, et al. Oct4 differentially regulates chromatin opening and enhancer transcription in pluripotent stem cells. Elife 11:e71533 (2022).

Yang S-H, et al. ZIC3 controls the transition from naive to primed pluripotency. Cell Reports 27: 3215 - 3227 (2019).

Contact: Alejandro De Los Angeles (adelosan@gmail.com)


<img src="https://raw.githubusercontent.com/PKief/vscode-material-icon-theme/ec559a9f6bfd399b82bb44393651661b08aaf7ba/icons/folder-github-open.svg" width="80" />

## ⚙️ Project Structure

```bash
.
├── README.md
├── atac_preprocessing.sh
├── brainspan_stats.R
├── embryo.sh
├── hipsci.sh
├── naive_formative.sh
└── oct4.sh

1 directory, 7 files
```
---

<img src="https://raw.githubusercontent.com/PKief/vscode-material-icon-theme/ec559a9f6bfd399b82bb44393651661b08aaf7ba/icons/folder-src-open.svg" width="80" />

## 💻 Modules
<details closed><summary>.</summary>

| File                  | Summary                                                                                                                                                                                                                                                                                                                                                                                                         |
|:----------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| embryo.sh             | This code replicates the original TOBIAS paper by Bentsen et al, 2020. It merges and sorts BAM files for each embryonic development stage, runs MACS2 on the merged BAM files, creates a merged peaks file, runs TOBIAS ATACorrect to correct for Tn5 bias, runs TOBIAS FootprintScores to calculate footprinting scores, and runs TOBIAS BINDetect to identify bound/unbound status of single TF binding sites |
| atac_preprocessing.sh | This code is a script template for submitting batch jobs to the SUN Grid Engine. It loads modules, takes in an argument from the command line, trims adapters from raw sequencing data FASTQ files using Trim Galore, generates FastQC reports from trimmed adapter files, and aligns trimmed adapter files to a genome using STAR.                                                                             |
| hipsci.sh             | This code uses TOBIAS to analyze a hiPSC-derived neuron dataset from HIPSCI. It merges and sorts BAM files, runs MACS2 to call peaks, corrects for Tn5 bias, calculates footprinting scores, and identifies bound/unbound sites of single TF binding sites.                                                                                                                                                     |
| brainspan_stats.R     | This code reads in ASCL1 data from Brainspan, finds rows with "frontal cortex" in the brain_region column, calculates the mean and standard error for the rows before row 239 (prenatal data) and after row 239 (postnatal data), and performs a t-test to compare the two.                                                                                                                                     |
| naive_formative.sh    | This code uses TOBIAS to compare naive pluripotency (d0) and formative pluripotency (d1) samples. BAM files from STAR are merged and sorted using samtools, and peak files from MACS2 are merged.                                                                                                                                                                                                               |
| oct4.sh               | This code uses the TOBIAS suite of tools to analyze ATAC-seq data from Xiong et al, 2022. It merges and sorts BAM files from STAR, runs MACS2 to call peaks, creates a merged peaks file, and uses TOBIAS ATACorrect to correct for Tn5 bias.                                                                                                                                                                   |

</details>
