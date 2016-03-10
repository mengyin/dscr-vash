# Run the dsc on local computer
library(dscr)

dsc_gtex = new.dsc("gtex","dsc-gtex-files")
source("scenarios.R")
source("methods.R")
source("score.R")

vash2loglike =function(output){
  loglike = output$fit$loglik
  return(list(loglike=loglike))
} 
addOutputParser(dsc_gtex,"vash2loglike",vash2loglike,"vash_output","loglike_output")

addScore(dsc_gtex,score,name="score",outputtype="loglike_output")

res=run_dsc(dsc_gtex)

save(res,file="res_scaled.Rdata")

