# Scores:
# loglike: log-likelihood of the variance model
# RMSE.var: average root squared error of gene-specific variances over all genes
# RMSE.var = sqrt(mean((var.est-var.true)^2))
# RMSE.prec: average root squared error of gene-specific precisions over all genes
# RMSE.prec = sqrt(mean((1/var.est-1/var.true)^2))
# dp005, fdp005: discovery proportion and false discovery proportion at 0.05 threshold

score_loglike = function(data, output){
  if(is.null(output$loglike)){
    loglike = NA
  }else{
    loglike = output$loglike
  }
  
  RMSE.prec = sqrt(mean((1/data$meta$truese^2-1/output$s2.est)^2))
  RMSE.var = sqrt(mean((data$meta$truese^2-output$s2.est)^2))
  
  dp005 = mean(output$qvalue<=0.05)
  fdp005 = sum(output$qvalue<=0.05 & data$meta$null==1)/sum(output$qvalue<=0.05)
  
  res = c(RMSE.prec, RMSE.var, loglike, dp005, fdp005)
  names(res) = c('RMSE.prec', 'RMSE.var', 'loglike', 'dp005', 'fdp005')
  
  return(res)
}
