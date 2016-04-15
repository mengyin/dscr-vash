# Make datasets for GTEx RNA-seq tissue pair comparisons,
# where the fist half samples come from tissue1 and 
# the rest come from tissue2
# Use voom transformation and linear models to estimate
# the effect sizes and standard errors 
datamaker = function(args){  
  tissue = args$tissue
  
  # rawdata1 = readtissue(args$path, tissue[1])
  rawdata1 = read.table(paste0(path,"/",args$tissue[1],".txt"),header=TRUE)
  
  Nsamp = args$Nsamp # Number of samples in each of the 2 groups
  
  
  if (length(tissue)>1){
    # rawdata2 = readtissue(args$path, tissue[2])
    rawdata2 = read.table(paste0(path,"/",args$tissue[2],".txt"),header=TRUE)
    
    if (is.null(args$Nsamp)){
      Nsamp = min(dim(rawdata1)[2],dim(rawdata2)[2])
    }
    if (dim(rawdata1)[2]<Nsamp | dim(rawdata2)[2]<Nsamp){
      stop("Not enough samples in the raw dataset!")
    }
    counts = cbind(rawdata1[,1:Nsamp], rawdata2[,1:Nsamp])
  }
  
  # Remove genes without any reads
  counts = counts[apply(counts,1,sum)>0,]
  
  # Take the top Ngene high-expressed genes
  Ngene = args$Ngene 
  if (!is.null(Ngene)){
    Ngene = min(Ngene, dim(counts)[1])
    counts = counts[sort(order(rowSums(counts),decreasing=TRUE)[1:Ngene]),]
  }
  Ngene = dim(counts)[1]
  
  # Model's design: Nsamp samples for group A and Nsamp samples for group B
  condition = factor(rep(1:2,each=Nsamp))
  design = model.matrix(~condition)
  
  # Ground truth of null hypotheses: beta_g=0
  null = rep(0,Ngene)
  
  # Voom transformation
  library(edgeR)
  dgecounts = DGEList(counts=counts,group=condition)
  if (args$voom.normalize == TRUE){
    dgecounts = calcNormFactors(dgecounts)
  }
  library(limma)
  v = voom(dgecounts,design,plot=FALSE)
  zdat.voom = apply(cbind(v$E,v$weights),1,wls.wrapper,g=condition)
  betahat.voom = zdat.voom[1,]
  sebetahat.voom = zdat.voom[2,]
  df.voom = length(condition)-2
  
  # Quasi-binomial glm
  zdat.qb = counts.associate(counts, condition)
  betahat.qb = zdat.qb[3,]
  sebetahat.qb = zdat.qb[4,]
  dispersion.qb = zdat.qb[5,]
  df.qb = length(condition)-2 
  
  # meta data
  meta = list(tissue=tissue, null=null, 
              args=args)
  
  # input data
  input = list(v=v, betahat.voom=betahat.voom, sebetahat.voom=sebetahat.voom, df.voom=df.voom,
               betahat.qb=betahat.qb, sebetahat.qb=sebetahat.qb, df.qb=df.qb)  
  data = list(meta=meta,input=input)
  return(data)
}

# Weighted least squares regression
# g: formula
# ynweights: matrix of response y and corresponding weights
wls.wrapper = function(ynweights,g,...){
  y = ynweights[1:(length(ynweights)/2)]
  weights = ynweights[(length(ynweights)/2+1):length(ynweights)]
  y.wls = lm(y~g,weights=weights,...)
  
  # slope estimate & standard error
  c = as.vector(t(summary(y.wls)$coeff[2,1:2]))
  return(c)
}

# counts is a ngene (or nwindow) by nsample matrix of counts (eg RNAseq)
# g is an nsample vector of group memberships/covariate
# looks for association between rows and covariate
counts.associate=function(counts, g,pseudocounts=1,W=NULL,offset=NULL){
  y.counts=t(as.matrix(counts)) 
  col.sum = apply(y.counts, 2, sum)
  y.counts=y.counts[,col.sum>0] #remove 0 columns
  y.counts = y.counts+pseudocounts 
  if (is.null(offset)){
    offset = apply(y.counts,1,sum)
  }
  
  y.prop = y.counts/apply(y.counts,1,sum) # compute proportions
  zdat = apply(y.prop,2,glm.binomial.wrapper,g=g,W=W,weights=offset,epsilon=1e-6)  #estimate effect sizes and standard errors
  #zdat.ash = ash(zdat[3,],zdat[4,],df=2,method='fdr') #shrink the estimated effects
  #return(list(zdat=zdat,zdat.ash=zdat.ash))
  return(zdat)
}

glm.binomial.wrapper = function(y,g,W=NULL,...){
  if (is.null(W)){
    y.glm=safe.quasibinomial.glm(y~g,...)
  }else{
    y.glm=safe.quasibinomial.glm(y~g+W,...)
  }
  
  return(c(get.coeff(y.glm),summary(y.glm)$dispersion))
}


#fill NAs with 0s (or other value)
fill.nas=function(x,t=0){
  x[is.na(x)]=t
  return(x)
}

#get estimates and standard errors from a glm object
#return NAs if not converged
get.coeff=function(x.glm){
  c=as.vector(t(summary(x.glm)$coeff[,1:2]))  
  if(x.glm$conv){return(c)} else {return(rep(NA,length(c)))}
}

# use glm to fit quasibinomial, but don't allow for underdispersion!
safe.quasibinomial.glm=function(formula,forcebin=FALSE,...){
  if(forcebin){
    fm=glm(formula,family=binomial,...)
  } else{
    fm = glm(formula,family=quasibinomial,...)
    if(is.na(summary(fm)$dispersion) | summary(fm)$dispersion<1){
      fm=glm(formula,family=binomial,...)
    }
  }
  return(fm)
}

# Randomly subsample data for each gene
# gene: a vector of reads for one gene
# Nsamp: # of samples wanted
sampleingene = function(gene, Nsamp){
  sample = sample(length(gene),Nsamp)
  return(c(gene[sample],sample))
}

# Randomly select samples
# counts: full count matrix
# Nsamp: # of samples wanted
# breaksample: flag, if select different samples for each gene
selectsample = function(counts, Nsamp, breaksample){
  if (breaksample==FALSE){
    subsample = sample(1:dim(counts)[2],Nsamp)
    counts = counts[,subsample]
    subsample = t(matrix(rep(subsample, dim(counts)[1]), ncol=dim(counts)[1]))
  }else{
    temp = t(apply(counts, 1, sampleingene, Nsamp=Nsamp))
    counts = temp[,1:Nsamp]
    subsample = temp[,(Nsamp+1):(2*Nsamp)]
  }
  return(list(counts=counts, subsample=subsample))
}

# Read dataset for a specific tissue
readtissue = function(path, tissue){
  tis = read.table(paste0(path,"sample_tissue.txt"), header=TRUE)
  
  tissue.idx = grep(tissue,tis[,2],fixed=TRUE)
  cols = rep("NULL",dim(tis)[1])
  cols[tissue.idx]="numeric"
  
  data = read.table(paste0(path,"GTEx_Analysis_v6_RNA-seq_RNA-SeQCv1.1.8_gene_reads.gct_new.txt"),
                    colClasses = cols, header = TRUE)
  return(data)
}