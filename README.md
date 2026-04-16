# RNA-seq Analysis: SMARCE1 and NF2 Loss in Meningioma

<div align="center">

[![Analysis Report](https://img.shields.io/badge/Analysis-Interactive_Report-blue?style=for-the-badge)](https://ghsamuel.github.io/rnaseq-smarce1-meningioma/scripts/05_R_analysis/Deseq2_quarto.html)
[![DOI](https://img.shields.io/badge/DOI-Nature_Genetics-green?style=for-the-badge)](https://doi.org/10.1038/s41588-022-01077-0)
[![GEO](https://img.shields.io/badge/GEO-GSE175385-orange?style=for-the-badge)](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE175385)

**Comparative transcriptomic analysis revealing distinct molecular mechanisms in meningioma subtypes**

[View Report](https://ghsamuel.github.io/rnaseq-smarce1-meningioma/scripts/05_R_analysis/Deseq2_quarto.html) • [Methods](#methods) • [Results](#results-highlights)

</div>

---

## Overview

Differential expression analysis of **SMARCE1-null** and **NF2-null** meningioma cell models using DESeq2 and pathway enrichment. This analysis reveals:

| Condition | DE Genes | Upregulated | Downregulated | Key Pathways |
|-----------|----------|-------------|---------------|--------------|
| **SMARCE1-null** | 8,037 | 3,985 | 4,052 | Developmental processes, ECM metabolism |
| **NF2-null** | 4,067 | 2,103 | 1,964 | Immune signaling, cytokine response |

### Key Discoveries

- ✓ **Distinct mechanisms**: SMARCE1 and NF2 loss drive tumorigenesis through completely different pathways
- ✓ **Balanced regulation**: Both conditions show ~50/50 split of up/downregulated genes
- ✓ **Clear separation**: PCA shows distinct transcriptional signatures for each condition
- ✓ **Mechanistic insight**: Pathway analysis confirms different meningioma subtypes have distinct molecular origins

---

## Quick Start

### View the Analysis

**[→ Interactive HTML Report](https://ghsamuel.github.io/rnaseq-smarce1-meningioma/scripts/05_R_analysis/Deseq2_quarto.html)**

The report includes:
- Quality control metrics
- Differential expression analysis
- Volcano plots and MA plots
- PCA and hierarchical clustering
- GO enrichment and GSEA analysis
- Interactive visualizations

---

## Pipeline

```mermaid
graph LR
    A[Raw FASTQ] --> B[QC: FastQC/MultiQC]
    B --> C[Trimming: Trimmomatic]
    C --> D[Alignment: HISAT2]
    D --> E[Quantification: HTSeq]
    E --> F[DESeq2 Analysis]
    F --> G[Pathway Enrichment]
    G --> H[Visualization & Report]
```

---

## Methods

### Differential Expression
- **Tool**: DESeq2 (negative binomial GLM)
- **Normalization**: Size factors with dispersion estimation
- **Shrinkage**: Adaptive shrinkage (`ashr`) for accurate effect sizes
- **Threshold**: Adjusted p-value < 0.1 (Benjamini-Hochberg)

### Pathway Analysis
- **GO Enrichment**: clusterProfiler with hypergeometric test
- **GSEA**: Gene Set Enrichment Analysis using ranked gene lists
- **Visualization**: Network plots, ridge plots, upset plots

### Quality Control
- **Pre-alignment**: FastQC, MultiQC, adapter trimming
- **Post-alignment**: Mapping rates, strand specificity, duplication levels
- **Expression QC**: PCA, sample correlation, top gene validation

---

## Repository Structure

```
rnaseq-smarce1-meningioma/
│
├── metadata/
│   └── kadoch_metadata.csv              # Sample annotations (14 samples)
│
├── scripts/
│   ├── 01_rawdata/                      # SRA download
│   ├── 02_QC/                           # Quality control & trimming
│   ├── 03_align/                        # HISAT2 alignment
│   ├── 04_count/                        # HTSeq quantification
│   └── 05_R_analysis/
│       ├── Deseq2_quarto.qmd            # Analysis source code
│       ├── Deseq2_quarto.html           # Rendered report
│       ├── references.bib               # Citations
│       └── 05_results/                  # Output files
│           ├── *_ALL_genes.csv          # Complete results
│           ├── *_significant_*.csv      # Filtered gene lists
│           ├── *_GO_all.csv             # GO enrichment
│           └── *_GSEA.csv               # GSEA results
│
└── README.md
```

---

## Results Highlights

<table>
<tr>
<td width="50%">

### SMARCE1-null vs WT

**8,037 differentially expressed genes**

**Top enriched pathways:**
- Skeletal system development
- Tissue morphogenesis  
- Extracellular matrix organization
- Negative regulation of cell proliferation

**Biological interpretation:**  
Loss of SMARCE1 disrupts developmental programs and structural organization, consistent with its role in chromatin remodeling during differentiation.

</td>
<td width="50%">

### NF2-null vs WT

**4,067 differentially expressed genes**

**Top enriched pathways:**
- Defense response
- Cytokine production
- Protein phosphorylation
- Immune system activation

**Biological interpretation:**  
NF2 loss triggers immune and inflammatory signaling cascades, suggesting a distinct tumorigenic mechanism from SMARCE1.

</td>
</tr>
</table>

---

## Tech Stack

<div align="center">

![R](https://img.shields.io/badge/R-276DC3?style=flat-square&logo=r&logoColor=white)
![Bioconductor](https://img.shields.io/badge/Bioconductor-1F8B4C?style=flat-square)
![Quarto](https://img.shields.io/badge/Quarto-75AADB?style=flat-square)
![FastQC](https://img.shields.io/badge/FastQC-Quality_Control-orange?style=flat-square)
![HISAT2](https://img.shields.io/badge/HISAT2-Alignment-red?style=flat-square)

</div>

**Core Analysis**
- DESeq2, clusterProfiler, EnhancedVolcano
- ggplot2, pheatmap, enrichplot

**Pipeline Tools**
- FastQC, MultiQC, Trimmomatic
- HISAT2, HTSeq-count
- SLURM HPC for batch processing

---

## Data Source

**Publication**  
St. Pierre, R., et al. (2022). SMARCE1 deficiency generates a targetable mSWI/SNF dependency in clear cell meningioma. *Nature Genetics*, 54, 861-873.  
DOI: [10.1038/s41588-022-01077-0](https://doi.org/10.1038/s41588-022-01077-0)

**Dataset**  
- **GEO Accession**: GSE175385
- **Samples**: 14 (6 WT, 4 SMARCE1-null, 2 NF2-null, 2 parental)
- **Platform**: Illumina NextSeq 500
- **Read Type**: 75bp single-end
- **Library Prep**: Illumina TruSeq Stranded mRNA

---

## Author

<div align="center">

**Glady Hazitha Samuel, PhD**

Bioinformatics Analyst | University of Connecticut

[![GitHub](https://img.shields.io/badge/GitHub-ghsamuel-181717?style=flat-square&logo=github)](https://github.com/ghsamuel)
[![Email](https://img.shields.io/badge/Email-glady.samuel%40uconn.edu-red?style=flat-square&logo=gmail)](mailto:glady.samuel@uconn.edu)

</div>

---

## Citation

If you use this analysis, please cite:

```bibtex
@article{stpierre2022smarce1,
  title={SMARCE1 deficiency generates a targetable mSWI/SNF dependency in clear cell meningioma},
  author={St. Pierre, R and Collings, CK and Sam{\'e} Guerra, D and others},
  journal={Nature Genetics},
  volume={54},
  pages={861--873},
  year={2022}
}
```

---

<div align="center">

**[↑ Back to Top](#rna-seq-analysis-smarce1-and-nf2-loss-in-meningioma)**

</div>
