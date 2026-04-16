#!/bin/bash
#SBATCH --job-name=trimmomatic
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=15G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jtz25002@uconn.edu
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err
#SBATCH --array=[1-45]%10

hostname
date

#################################################################
# Trimmomatic
#################################################################

module load Trimmomatic/0.39
module load parallel/20180122

# set input/output directory variables
INDIR=../../data/fastq/
TRIMDIR=../../results/02_qc/trimmed_fastq
mkdir -p $TRIMDIR

# adapters to trim out
ADAPTERS=/isg/shared/apps/Trimmomatic/0.39/adapters/TruSeq3-SE.fa

# accession list
ACCLIST=../../metadata/accessionlist.txt

# run trimmomatic

SAMPLE=$( sed -n ${SLURM_ARRAY_TASK_ID}p ${ACCLIST} )

java -jar $Trimmomatic SE -threads 4 \
        ${INDIR}/${SAMPLE}.fastq.gz \
        ${TRIMDIR}/${SAMPLE}_trimmed.fastq.gz \
        ILLUMINACLIP:${ADAPTERS}:2:30:10 \
        SLIDINGWINDOW:4:15 \
        MINLEN:45


