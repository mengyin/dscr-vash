# Scores:
# MSE.var: average square error of gene-specific variances over all genes
# MSE.var = mean((var.est-var.true)^2)
# MSE.prec: average square error of gene-specific precisions over all genes
# MSE.prec = mean((1/var.est-1/var.true)^2)
# FDR: false discovery rate for testing if gene-specific effect is 0

score = function(data, output){
  RMSE.prec = sqrt(mean((1/data$meta$truese^2-1/output$s2.est)^2))
  RMSE.var = sqrt(mean((data$meta$truese^2-output$s2.est)^2))
  
  o = order(output$qvalue)
  FDR = cumsum(data$meta$null[o])/(1:length(output$qvalue))
   
  res = c(RMSE.var, RMSE.prec, FDR)

  names(res) = c('RMSE.var',"RMSE.prec",
                 paste('FDR',1:length(output$qvalue), sep=''))

  return(res)
}
