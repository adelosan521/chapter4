##for loop to run script across all files

for file in `cat file_list.txt`; do sbatch --job-name $file --mail-user adelosan@gmail.com --mail-type begin,end,fail --wrap="./script.sh $file"; done

#!/bin/sh

##########################################################################
## A script template for submitting batch jobs. To submit a batch job, 
## please type
##
##    qsub myprog.sh
##
## Please note that anything after the first two characters "#$" on a line
## will be treated as a SUN Grid Engine command.
##########################################################################

## The following to run programs in the current working directory

#$ -cwd


## Specify a queue

#$ -q batchq


## The following two lines will send an email notification when the job is 
## Ended/Aborted/Suspended - Please replace "UserName" with your own username.

#$ -M aangeles
#$ -m eas

## Takes in argument from command line
file=$1

## Load modules
echo "$file is going to be processed"
module load trim_galore/0.6.5
module load fastqc
module load STAR/2.6.0c
module load python3-cbrg

## Creates variable of file without _1.fastq and directory path
base=$(basename ${file/_1.fastq/});

## Trim adapters from raw sequencing data FASTQ files using Trim Galore
trim_galore --paired --retain_unpaired -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -a2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT ${file} ${file/_1/_2} -o /project/tunbridgelab/aangeles/atacseq/hipsci/

## Wait until trimmed adapter files are generated before proceeding to next steps
while [ ! -e ${base}_2_val_2.fq ]; do sleep 10; done
while [ ! -e ${base}_1_val_1.fq ]; do sleep 10; done

## Generate FastQC reports from trimmed adapter files
fastqc -f fastq ${base}_1_val_1.fq.gz ${base}_2_val_2.fq.gz
## Align trimmed adapter files to genome using STAR

##Modified STAR commands
STAR alignEndsType EndToEnd --outFilterMismatchNoverLmax 0.1 --outFilterScoreMinOverLread 0.66 --outFilterMatchNminOverLread 0.66 --outFilterMatchNmin 20 --alignIntronMax 1 --alignSJDBoverhangMin 999 --alignEndsProtrude 10 ConcordantPair --alignMatesGapMax 2000 --outMultimapperOrder Random --outFilterMultimapNmax 999 --outSAMmultNmax 1 --runThreadN 8 --genomeDir /project/tunbridgelab/aangeles/atacseq/hipsci/ --readFilesIn ${base}_1_val_1.fq.gz ${base}_2_val_2.fq.gz --outFileNamePrefix /project/tunbridgelab/aangeles/atacseq/hipsci/${base}_ --twopassMode Basic --outSAMstrandField intronMotif --readFilesCommand zcat --outSAMtype BAM Unsorted

##Generate STAR index
STAR --runThreadN 8 --runMode genomeGenerate --genomeDir /project/tunbridgelab/aangeles/atacseq/hipsci/ --genomeFastaFiles /project/tunbridgelab/aangeles/atacseq/hipsci/GRCh38.primary_assembly.genome.fa --sjdbGTFfile /project/tunbridgelab/aangeles/atacseq/hipsci/new_annotation.gtf --sjdbOverhang 74

