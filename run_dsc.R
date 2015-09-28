library(dscr)

dsc_vash = new.dsc("vash","dsc-vash-files")
source("scenarios.R")
source("methods.R")


limma2beta_est =function(output){
  return (list(s2.est=output$s2.post*output$stdev.unscaled^2,
               qvalue=qvalue(output$p.value)$qval,
               loglike = limma_loglike(output)))
} 
addOutputParser(dsc_vash,"limma2beta",limma2beta_est,"limma_output","est_output")

vash2beta_est =function(output){
  return (list(s2.est = 1/apply(output$PosteriorPi*output$PosteriorShape/output$PosteriorRate,1,sum),
               qvalue=output$qvalue,
               loglike = output$fit$loglik))
#   return (list(s2.est = output$PosteriorMean^2,
#                qvalue=output$qvalue,
#                loglike = output$fit$loglik))
} 
addOutputParser(dsc_vash,"vash2beta",vash2beta_est,"vash_output","est_output")

# jointash2beta_est =function(output){
#   return (list(s2.est=output$va$PosteriorMean^2, qvalue=output$fit$qvalue))
# } 
# addOutputParser(dsc_vash,"jointash2beta",jointash2beta_est,"jointash_output","est_output")
# 
# ash2beta_est =function(output){
#   return (list(s2.est=NA, qvalue=output$fit$qvalue))
# } 
# addOutputParser(dsc_vash,"ash2beta",ash2beta_est,"ash_output","est_output")

# Long scores (including FDR)
# source("score.R")
# addScore(dsc_vash,score,name="score",outputtype="est_output")

# Log-likelihood scores
source("score_loglike.R")
addScore(dsc_vash,score_loglike,name="score_loglike",outputtype="est_output")


res=run_dsc(dsc_vash)
save(res,file="res.Rdata")
