# Scores:
# MSE.var: average square error of gene-specific variances over all genes
# MSE.var = mean((var.est-var.true)^2)
# MSE.prec: average square error of gene-specific precisions over all genes
# MSE.prec = mean((1/var.est-1/var.true)^2)
# FDR: false discovery rate for testing if gene-specific effect is 0

score_loglike = function(data, output){
  if(is.null(output$loglike)){
    loglike = NA
  }else{
    loglike = output$loglike
  }
  
  RMSE.prec = sqrt(mean((1/data$meta$truese^2-1/output$s2.est)^2))
  RMSE.var = sqrt(mean((data$meta$truese^2-output$s2.est)^2))
  
  highvar.idx = (data$input$sebetahat >= quantile(data$input$sebetahat,0.99))
  lowvar.idx = (data$input$sebetahat <= quantile(data$input$sebetahat,0.01))
  RMSE.prec.highvar = sqrt(mean(((1/data$meta$truese^2-1/output$s2.est)^2)[highvar.idx]))
  RMSE.var.highvar = sqrt(mean(((data$meta$truese^2-output$s2.est)^2)[highvar.idx]))
  RMSE.prec.lowvar = sqrt(mean(((1/data$meta$truese^2-1/output$s2.est)^2)[lowvar.idx]))
  RMSE.var.lowvar = sqrt(mean(((data$meta$truese^2-output$s2.est)^2)[lowvar.idx]))
  
  qval005 = mean(output$qvalue<=0.05)
  fdr005 = sum(output$qvalue<=0.05 & data$meta$null==1)/sum(output$qvalue<=0.05)
  res = c(RMSE.prec, RMSE.var, loglike,
          RMSE.prec.highvar, RMSE.var.highvar, RMSE.prec.lowvar, RMSE.var.lowvar,
          qval005,fdr005)
  names(res) = c('RMSE.prec', 'RMSE.var', 'loglike',
                 'RMSE.prec.highvar', 'RMSE.var.highvar', 'RMSE.prec.lowvar', 'RMSE.var.lowvar',
                 'qval005','fdr005')
  
  return(res)
}
