#!/bin/bash
#SBATCH --job-name=fasterq_dump_xanadu
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 12
#SBATCH --mem=15G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jtz25002@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

#################################################################
# Download fastq files from SRA 
#################################################################

# load software
module load parallel/20180122
module load sratoolkit/3.0.1

# The data are from this study:
    # https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE174360
    # https://www.ncbi.nlm.nih.gov/bioproject/PRJNA729512

TMPDIR=/sandbox/gsamuel/smarce/tmp
OUTDIR=../../data/fastq
mkdir -p ${OUTDIR}
mkdir -p ${TMPDIR}
#METADATA=../../metadata/SraRunTable.txt

# Get a list of SRA accession numbers to download, put them in a file
 
# we're going to work only with RNAseq Ac7 samples in this project. 
# the metadata table was downloaded from the SRA's "Run Selector" page.
#https://www.ncbi.nlm.nih.gov/Traces/study/?query_key=2&WebEnv=MCID_690a3ea326304dbcefc5b5f1&o=acc_s%3Aa 

# extract rows matching our population names, pull out the SRA accession number (the first column)
ACCLIST=../../metadata/accessionlist.txt
#cut -f1 -d "," ${METADATA} > $ACCLIST

# use parallel to download 2 accessions at a time. 
cat $ACCLIST | parallel -j 2 "fasterq-dump -O ${OUTDIR} {}"

# compress the files 
ls ${OUTDIR}/*fastq | parallel -j 12 gzip
