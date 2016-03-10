# This DSC (dynamic statistical comparison) compares the log-likelihoods of 
# single IG prior variance model (limma)
# and mixture IG prior variance model (vash) on GTEx RNA-seq data.
# For each tissue pairs, we estimate the effect sizes and standard errors,
# and use limma & vash to shrink the variances.
# 
# DSC outline: 
# scenarios: all possible tissue pair comparisons
# methods: limma, vash
# scores: log-likelihood

# Below is the code to run this dsc on cluster:
library(dscr)

# fetch node info
args = commandArgs(TRUE)

# initialize a new dsc
dsc_gtex = new.dsc("gtex","dsc-gtex-files")

# define scenarios: all tissue pair comparisons
sourceDir("datamakers")
fileName = 'data_path.txt'
path = gsub("[[:space:]]", "", readChar(fileName, file.info(fileName)$size))

tis = read.table(paste0(path,"/gtex/sample_tissue.txt"), header=TRUE,stringsAsFactors=FALSE)
uniqtis = gsub("[[:space:]]","",unique(tis[,2]))
uniqtis = uniqtis[!is.na(uniqtis)]
comb = t(outer(uniqtis,uniqtis,FUN=paste))
comb = gsub("[[:space:]]", ",",comb[lower.tri(comb)])

addScenario(dsc_gtex,name=comb[args[2]], fn=datamaker,
            args=list(tissue=strsplit(comb[args[2]],",")[[1]], 
                      path=path,
                      Nsamp=NULL, Ngene=20000,
                      voom.normalize=TRUE),
            seed=1)

# add methods and scores 
source("methods.R")

# convert vash's output to standard log-likelihood output
vash2loglike =function(output){
  loglike = output$fit$loglik
  return(list(loglike=loglike))
} 
addOutputParser(dsc_gtex,"vash2loglike",vash2loglike,"vash_output","loglike_output")

# add scores
source("score.R")
addScore(dsc_gtex,score,name="score",outputtype="loglike_output")

# run dsc
res = run_dsc(dsc_gtex)

# save(res,file="res.Rdata")