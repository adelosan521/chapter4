##TOBIAS to replicate Bentsen et al, 2020 original TOBIAS paper
##This code replicates the original TOBIAS paper by Bentsen et al, 2020. The code for merging and sorting BAM files is in the "oct4.sh." script. It runs MACS2 on merged and sorted BAM files, creates a merged peaks file, runs TOBIAS ATACorrect to correct for Tn5 bias, runs TOBIAS FootprintScores to calculate footprinting scores, and runs TOBIAS BINDetect to identify bound/unbound status of single TF binding sites. The minor modification made to TOBIAS to identify all bound TFs within a chromatin peak is provided in the "hipsci.sh" script.

## BAM files for each embryonic development stage were merged and sorted similar to as described in "oct4" script

## MACS2 on merged BAM files (example: 2C data, but repeated for 4C, 8C, ICM, ESC)
macs2 callpeak -t 2C_sorted.bam -f BAM -n 2C --outdir 2C_mac2 --nomodel --shift -100 --extsize 200 --broad

##create merged peaks file (for 2C, 4C, 8C, ICM, and ESC)

cat /project/tunbridgelab/aangeles/atacseq/validation/embryo/2C_macs2/2C_peaks-chrM.broadPeak /project/tunbridgelab/aangeles/atacseq/validation/embryo/4C_macs2/4C_peaks-chrM.broadPeak /project/tunbridgelab/aangeles/atacseq/validation/embryo/8C_macs2/8C_peaks-chrM.broadPeak /project/tunbridgelab/aangeles/atacseq/validation/embryo/ICM_macs2/ICM_peaks-chrM.broadPeak /project/tunbridgelab/aangeles/atacseq/validation/embryo/ESC_macs2/ESC_peaks-chrM.broadPeak | bedtools sort | bedtools merge > merged_peaks.bed

##TOBIAS ATACorrect (correction of Tn5 bias) - shown for 2C data, but repeated for 4C, 8C, ICM, ESC

TOBIAS ATACorrect --bam 2C_sorted.bam --peaks merged_peaks.bed --genome GRCh38.primary_assembly.genome.fa --blacklist hg38-blacklist.v2.bed --outdir 2C_macs2_blacklist_merged --cores 8

##Footprints (shown for 2C) - to calculate footprinting scores

TOBIAS FootprintScores --signal /project/tunbridgelab/aangeles/atacseq/validation/embryo/2C_macs2_blacklist/2C_sorted_corrected.bw --regions merged_peaks.bed --output 2C_macs2_blacklist_merged_footprints.bw --cores 8

##BINDetect (shown for 2C) - to identify bound/unbound status of single TF binding sites

TOBIAS BINDetect --motifs JASPAR2022_CORE_non-redundant_pfms_jaspar.txt --signals 2C_macs2_blacklist_merged_footprints.bw --genome GRCh38.primary_assembly.genome.fa --peaks merged_peaks.bed --outdir 2C_blacklist_macs2_merge_BINDetect --cond_names 2C 
