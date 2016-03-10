# This DSC (dynamic statistical comparison) compares the variance (precision) 
# estimation RRMSEs of single IG prior variance model (limma)
# and mixture IG prior variance model (vash) on simulated data.
# 
# DSC outline: 
# scenarios: simulation scenarios A-H (with different prior shapes) and a few scenarios based on GTEx data.
#            For each scenario we try df=3,10,50.
# methods: original t-test, limma, limma-robust, vash
# scores: RRMSE

# Below is the code to run this dsc:
library(dscr)

# initialize a new dsc
dsc_vash = new.dsc("vash","dsc-vash-files")

# add scenarios and methods
source("scenarios.R")
source("methods.R")

# convert limma or vash's output to standard esitimation output
limma2beta_est =function(output){
  return (list(s2.est=output$s2.post*output$stdev.unscaled^2,
               qvalue=qvalue(output$p.value)$qval,
               loglike = limma_loglike(output)))
} 
addOutputParser(dsc_vash,"limma2beta",limma2beta_est,"limma_output","est_output")

vash2beta_est =function(output){
  return (list(s2.est = output$sd.post^2,
               qvalue = output$qvalue,
               loglike = output$fit$loglik))
} 
addOutputParser(dsc_vash,"vash2beta",vash2beta_est,"vash_output","est_output")

# Long scores (including FDR)
# source("score.R")
# addScore(dsc_vash,score,name="score",outputtype="est_output")

# add log-likelihood scores
source("score_loglike.R")
addScore(dsc_vash,score_loglike,name="score_loglike",outputtype="est_output")

# run dsc
res=run_dsc(dsc_vash)
save(res,file="res.Rdata")
