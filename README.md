## Introduction
This repo is intended to contain code to reproduce results from the paper "Variance Adaptive Shrinkage (vash): Flexible Empirical Bayes estimation of variances".

## Directory Structure
Here's a brief summary of the directory structure.

code: contains 2 DSC (dynamic statistical comparison) directories, which generated results in the Results section. The DSC "dsc-vash" compares the RRMSEs of limma, limmaR and vash on several simulation scenarios with different degrees of freedom (3,10,50). The DSC "dsc-gtex-vash" performs differential expression analysis between every pair of tissue for GTEx RNA-seq data, and compares the log-likelihoods of single IG variance prior model (limma) and mixture IG variance prior model (vash).

plots: contains the R code to plot the figures in the paper.

paper: the paper


