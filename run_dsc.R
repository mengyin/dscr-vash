library(dscr)

dsc_vash = new.dsc("vash","dsc-vash-files")
source("scenarios.R")
source("methods.R")
source("score.R")

vash2beta_est =function(output){
  return (list(s2.est=output$PosteriorMean^2, qvalue=output$qvalue))
} 
addOutputParser(dsc_vash,"vash2beta",vash2beta_est,"vash_output","est_output")

jointash2beta_est =function(output){
  return (list(s2.est=output$va$PosteriorMean^2, qvalue=output$fit$qvalue))
} 
addOutputParser(dsc_vash,"jointash2beta",jointash2beta_est,"jointash_output","est_output")

ash2beta_est =function(output){
  return (list(s2.est=NA, qvalue=output$fit$qvalue))
} 
addOutputParser(dsc_vash,"ash2beta",ash2beta_est,"ash_output","est_output")


addScore(dsc_vash,score,name="score",outputtype="est_output")

res=run_dsc(dsc_vash)
save(res,file="res.Rdata")