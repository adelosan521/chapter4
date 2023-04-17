## TOBIAS comparing naive pluripotency (d0) and formative pluripotency (d1) samples
## This code uses TOBIAS to compare naive pluripotency (d0) and formative pluripotency (d1) samples. BAM files from STAR are merged and sorted using samtools. Code for removing PCR duplicates, removing mitochondrial reads, removing blacklisted regions producing BAM files is featured in the "oct4.sh" script. Peak files from MACS2 are merged. Then TOBIAS is run to correct for Tn5 bias, generate footprint scores, and identifying bound/unbound sites.

## BAM files from STAR were merged and sorted using samtools as described in "oct4" script; macs2 was conducted on sorted merged BAM file

##merge peak files (from MACS2) of d0 and d1 samples (naive-formative)

cat /project/tunbridgelab/aangeles/atacseq/validation/naive-formative/d0/d0_peaks.broadPeak /project/tunbridgelab/aangeles/atacseq/validation/naive-formative/d1/d1_peaks.broadPeak | bedtools sort | bedtools merge > merged_peaks_d0vsd1.bed

##ATACorrect (correction of Tn5 bias) of d0 and d1 samples

TOBIAS ATACorrect --bam d0_sorted.bam --peaks merged_peaks_d0vsd1.bed --genome GRCm39.primary_assembly.genome.fa --blacklist mm10-blacklist.v2.bed --outdir d0_ATACorrect --cores 8

TOBIAS ATACorrect --bam d1_sorted.bam --peaks merged_peaks_d0vsd1.bed --genome GRCm39.primary_assembly.genome.fa --blacklist mm10-blacklist.v2.bed --outdir d1_ATACorrect --cores 8

##Footprints of d0 and d1 samples to calculate footprinting scores 

TOBIAS FootprintScores --signal /project/tunbridgelab/aangeles/atacseq/validation/naive-formative/d0_ATACorrect/d0_sorted_corrected.bw --regions merged_peaks_d0vsd1.bed --output d0vsd1_d1_footprints.bw --cores 8

TOBIAS FootprintScores --signal /project/tunbridgelab/aangeles/atacseq/validation/naive-formative/d1_ATACorrect/d1_sorted_corrected.bw --regions merged_peaks_d0vsd1.bed --output d0vsd1_d1_footprints.bw --cores 8

##Compare d0 and d1 samples using BINDetect function (identify bound/unbound sites, compare footprints from different conditions)

TOBIAS BINDetect --motifs JASPAR2022_CORE_non-redundant_pfms_jaspar.txt --signals d0vsd1_d0_footprints.bw d0vsd1_d1_footprints.bw --genome GRCm39.primary_assembly.genome.fa --peaks merged_peaks_d0vsd1-clean.bed --outdir d0_d1_comparison --cond_names d0_naive d1_formative
