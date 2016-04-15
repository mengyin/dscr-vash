## Introduction
This repo is intended to contain code to reproduce results from the paper "Variance Adaptive Shrinkage (vash): Flexible Empirical Bayes estimation of variances".

## Directory Structure
Here's a brief summary of the directory structure.

code: contains 2 DSC (dynamic statistical comparison) directories, which generated results in the Results section. The DSC "dsc-vash" compares the RRMSEs of limma, limmaR and vash on several simulation scenarios with different degrees of freedom (3,10,50). The DSC "dsc-gtex-vash" performs differential expression analysis between every pair of tissue for GTEx RNA-seq data, and compares the log-likelihoods of single IG variance prior model (limma) and mixture IG variance prior model (vash).

plots: contains the R code to plot the figures in the paper.

paper: the paper

## Reproduce Results
1. Clone (or download and unzip) this repository.
2. Install the `R` packages you need. To install the vashr package first you need to install devtools
```
install.packages("devtools")
library(devtools)
install_github("mengyin/vashr")
```
3. Prepare the GTEx datasets: register and log into [GTEx portal](http://www.gtexportal.org/home/datasets). Download `GTEx_Data_V6_Annotations_SampleAttributesDS.txt`, `GTEx_Analysis_v6_RNA-seq_RNA-SeQCv1.1.8_gene_reads.gct.gz` to the `data` subdirectory and decompress the latter file. Type `make all` in the `data` subdirectory. 
4. Within the repository directory type `make clean`. This will remove figure etc files that I have already included in the repository.
5. Within the repository directory type `make`. This will try to:

      i) Run all the code for the simulation studies.
It will take a while (hours), so you might want to run it overnight. This should create a bunch of output files in the `dsc-vash` and `dsc-gtex-vash` directory. Particularly you will know that it worked iff you can find the files `dsc-vash-files/res.RData` and `dsc-gtex-files/dsc_scaled.RData`.

      ii) Run the code in the `plots` directory. If successful you should have .eps files in the `paper` directory.

      iii)  `pdflatex` the paper.

If you have problems (more than likely!) you might like to try each of these steps in turn, by sequentially typing
`make output`, `make plots`, and `make paper`.

