# Remove the first 2 lines from GTEx_Analysis_v6_RNA-seq_RNA-SeQCv1.1.8_gene_reads.gct.txt
tail -n +3 GTEx_Analysis_v6_RNA-seq_RNA-SeQCv1.1.8_gene_reads.gct.txt > GTEx_Analysis_v6_RNA-seq_RNA-SeQCv1.1.8_gene_reads.gct_new.txt

# Save sample names into a separate file
sed -n 1p GTEx_Analysis_v6_RNA-seq_RNA-SeQCv1.1.8_gene_reads.gct_new.txt > samplename.txt