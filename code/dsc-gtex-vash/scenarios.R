# Scenarios: all combinations of tissue pair comparisons
# use the top 20,000 genes

sourceDir("datamakers")
fileName = 'data_path.txt'
path = gsub("[[:space:]]", "", readChar(fileName, file.info(fileName)$size))

tis = read.table(paste0(path,"/gtex/sample_tissue.txt"), header=TRUE,stringsAsFactors=FALSE)
uniqtis = gsub("[[:space:]]","",unique(tis[,2]))
uniqtis = uniqtis[!is.na(uniqtis)]

for (i in 1:(length(uniqtis)-1)){
  for (j in (i+1):length(uniqtis)){
    addScenario(dsc_gtex,name=paste0(uniqtis[i],",",uniqtis[j]), fn=datamaker,
                args=list(tissue=c(uniqtis[i],uniqtis[j]), 
                          path=path,
                          Nsamp=NULL, Ngene=20000,
                          voom.normalize=TRUE),
                seed=1)
  }
}

