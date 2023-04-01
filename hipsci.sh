##TOBIAS on hiPSC-derived neuron dataset from HIPSCI
##This code uses TOBIAS to analyze a hiPSC-derived neuron dataset from HIPSCI. The code for merging and sorting BAM files is in the "oct4.sh." script. It runs MACS2 on merged and sorted BAM files to call peaks, corrects for Tn5 bias, calculates footprinting scores, and identifies bound/unbound sites of single TF binding sites.

## BAM files for each hiPSC-derived neuron dataset were merged and sorted similar to as described in "oct4" script

## MACS2 on merged BAM files
macs2 callpeak -t super_merge_sorted.bam -f BAM -n neuron --outdir neuron_macs2 --nomodel --shift -100 --extsize 200 --broad

##TOBIAS ATACorrect (correction of Tn5 bias). 

TOBIAS ATACorrect --bam super_merge_sorted.bam --peaks /project/tunbridgelab/aangeles/atacseq/hipsci/merge/neuron_macs2/neuron_peaks.broadPeak --genome GRCh38.primary_assembly.genome.fa --blacklist hg38-blacklist.v2.bed --outdir neuron_macs2_blacklist --cores 8

##Footprints - to calculate footprinting scores

TOBIAS FootprintScores --signal /project/tunbridgelab/aangeles/atacseq/hipsci/merge/neuron_macs2_blacklist/super_merge_sorted_corrected.bw --regions /project/tunbridgelab/aangeles/atacseq/hipsci/merge/neuron_macs2/neuron_peaks.broadPeak --output neuron_merged_footprints.bw --cores 8

##BINDetect - to identify bound / unbound sites of single TF binding sites

TOBIAS BINDetect --motifs JASPAR2022_CORE_non-redundant_pfms_jaspar.txt --signals neuron_merged_footprints.bw --genome GRCh38.primary_assembly.genome.fa --peaks /project/tunbridgelab/aangeles/atacseq/hipsci/merge/neuron_macs2/neuron_peaks-chrM.broadPeak --outdir neuron_BINDetect --cond_names neuron 

## TOBIAS minor modification to identify all bound TFs within a chromatin peak (example shown for chromatin peak #2197)

for filename in `ls /project/tunbridgelab/aangeles/atacseq/hipsci/merge/neuron_BINDetect/*/beds/*_neuron_bound.bed`; do grep -w "neuron_peak_2197" $filename; done > All_TFBS_in_neuron_peak_2197.bed
