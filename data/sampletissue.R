# Read sample-tissue annotation
organized.by.tissue = read.delim("GTEx_Data_V6_Annotations_SampleAttributesDS.txt", stringsAsFactors=FALSE)
organized.by.tissue = organized.by.tissue[,c(1,6,7)]

samplename <- read.delim("samplename.txt", header=FALSE,stringsAsFactors=FALSE)
sample = as.data.frame(t(samplename),stringsAsFactors=FALSE)

# Get tissue list
tis = data.frame(name=sample$V1, tissue=organized.by.tissue[match(sample$V1, organized.by.tissue$SAMPID), 3],stringsAsFactors=FALSE)
tis = tis[-(1:2),]
write.table(tis,file="sample_tissue.txt")
uniqtis = unique(tis[,2])
uniqtis = uniqtis[!is.na(uniqtis)]

# Save data for each tissue
for (i in 1:length(uniqtis)){
  filename = paste0(gsub("[[:space:]]","",uniqtis[i]),".txt")
  if (file.exists(filename)){
    next
  }
  tissue.idx = grep(uniqtis[i],tis[,2],fixed=TRUE)
  cols = rep("NULL",dim(tis)[1])
  cols[tissue.idx]="numeric"
  
  data = read.table("GTEx_Analysis_v6_RNA-seq_RNA-SeQCv1.1.8_gene_reads.gct_new.txt",
                    colClasses = cols, header = TRUE)
  write.table(data,file=paste0(gsub("[[:space:]]","",uniqtis[i]),".txt"))
}