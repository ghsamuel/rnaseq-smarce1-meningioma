#!/bin/bash
#SBATCH --job-name=get_genome
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --mem=2G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jtz25002@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

echo `hostname`
date

#################################################################
# Download genome and annotation from 
#################################################################

# load software
module load samtools/1.16.1

# output directory
GENOMEDIR=../../genome
mkdir -p $GENOMEDIR

# we're using human genome (GENCODE Release 49 (GRCh38.p14))
    # we'll download the genome, GTF(CHR Basic gene annotation)and genome (Genome sequence, primary assembly (GRCh38)) fasta
    # https://www.gencodegenes.org/human/
 

# download the genome
wget -P ${GENOMEDIR} https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_49/GRCh38.primary_assembly.genome.fa.gz

# download the GTF annotation
wget -P ${GENOMEDIR} https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_49/gencode.v49.basic.annotation.gtf.gz

# download the transcript fasta
wget -P ${GENOMEDIR} https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_49/gencode.v49.transcripts.fa.gz

# decompress files
gunzip ${GENOMEDIR}/*gz

# generate simple samtools fai indexes 
samtools faidx ${GENOMEDIR}/GRCh38.primary_assembly.genome.fa
samtools faidx ${GENOMEDIR}/gencode.v49.transcripts.fa

