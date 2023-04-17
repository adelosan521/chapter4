##TOBIAS 
## This code uses the TOBIAS suite of tools to analyze ATAC-seq data from Xiong et al, 2022. It merges and sorts BAM files from STAR, removes PCR duplicates, removes mitochondrial reads, removes blacklisted regions, runs MACS2 to call peaks, creates a merged peaks file, and uses TOBIAS to correct for Tn5 bias, calculate footprint scores, and identify bound/unbound sites.

## merge BAM files (from STAR) (example: 0h data from Xiong et al, 2022). Data analyzed in thesis was 0 hour versus 15 hour depletion)

module load samtools
samtools merge ATAC-seq_0h_merge_unsorted.bam ATAC-seq_0h_Recovery_rep1_Aligned.out.bam ATAC-seq_0h_Recovery_rep2_Aligned.out.bam

## sort merged BAM files (example: 0h data)

samtools sort ATAC-seq_0h_merge_unsorted.bam -o ATAC-seq_0h_merge_sorted.bam

## remove PCR duplicates

module load picard-tools
java -jar picard.jar MarkDuplicates I=ATAC-seq_0h_merge_sorted.bam O=output.bam M=metrics.txt REMOVE_DUPLICATES=true ASSUME_SORTED=true VALIDATION_STRINGENCY=LENIENT

## remove mitochondrial reads (note "output.bam" from the picard command).

samtools view -h -F 4 -b output.bam | grep -v 'chrM\|MT' | samtools view -b -o ATAC-seq_0h_merge_sorted_filtered.bam

## remove blacklisted regions (uses bedtools -- note "filtered.bam" is the filtered.bam from removing mitochondrial reads; blacklist.bed is mm-10-blacklist.v2.bed for mouse)

module load bedtools
bedtools intersect -v -a ATAC-seq_0h_merge_sorted_filtered.bam -b blacklist.bed -wa -sorted -g genome.file > clean.bam

## MACS2 on merged, PCR duplicate-depleted and filtered BAM files (example: 0h data)

macs2 callpeak -t ATAC-seq_0h_merge_sorted_filtered.bam -f BAM -n 0h --outdir 0h --nomodel --shift -100 --extsize 200 --broad

##create merged peaks file (for 0h and 15h timepoints)

cat /project/tunbridgelab/aangeles/atacseq/validation/oct4/0h_rep1/0h_peaks.broadPeak /project/tunbridgelab/aangeles/atacseq/validation/oct4/0h_rep2/0h_peaks.broadPeak /project/tunbridgelab/aangeles/atacseq/validation/oct4/15h_rep1/15h_peaks.broadPeak /project/tunbridgelab/aangeles/atacseq/validation/oct4/15h_rep2/15h_peaks.broadPeak| bedtools sort | bedtools merge > merged_peaks_0_15h.bed

##TOBIAS ATACorrect (correction of Tn5 bias - example shown is 0h treatment and 15h depletion). Data analyzed in thesis was 0 hour versus 15 hour depletion

TOBIAS ATACorrect --bam ATAC-seq_0h_merge_sorted_filtered.bam --peaks merged_peaks_super.bed --genome GRCm39.primary_assembly.genome.fa --blacklist mm10-blacklist.v2.bed --outdir 0hvs15h --cores 8

TOBIAS ATACorrect --bam ATAC-seq_15h_merge_sorted_filtered.bam --peaks merged_peaks_super.bed --genome GRCm39.primary_assembly.genome.fa --blacklist mm10-blacklist.v2.bed --outdir 0hvs15h --cores 8

##Footprints (to calculate footprinting scores)

TOBIAS FootprintScores --signal /project/tunbridgelab/aangeles/atacseq/validation/oct4/0hvs15h_0h/0h_merge_sortedA_corrected.bw --regions merged_peaks_0_15h.bed --output 0hvs15h_0h_footprints.bw --cores 8

TOBIAS FootprintScores --signal /project/tunbridgelab/aangeles/atacseq/validation/oct4/0hvs15h_15h/15h_merge_sortedA_corrected.bw --regions merged_peaks_0_15h.bed --output 0hvs15h_15h_footprints.bw --cores 8

##Compare 0h and 15h BINDetect (identify bound/unbound sites, compare footprints from different conditions)

TOBIAS BINDetect --motifs JASPAR2022_CORE_non-redundant_pfms_jaspar.txt --signals 0hvs15h_0h_footprints.bw 0hvs15h_15h_footprints.bw --genome GRCm39.primary_assembly.genome.fa --peaks merged_peaks_0_15h-clean.bed --outdir 0h_15h_comparison --cond_names 0h 15h
