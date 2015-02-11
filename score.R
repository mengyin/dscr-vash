#This file should define your score function

score = function(data, output){
  MSE.prec = mean((1/data$meta$truese^2-1/output$s2.est)^2)
  MSE.var = mean((data$meta$truese^2-output$s2.est)^2)
  o = order(output$qvalue)
  FDR = cumsum(data$meta$null[o])/(1:length(output$qvalue))
  #res = as.list(c(MSE,FDR))
  #names(res) = c('MSE',paste('FDR',1:length(output$qvalue), sep=''))
  
  res = c(MSE.var,MSE.prec,FDR)
  #class(res) = "data.frame"
  names(res) = c('MSE.var',"MSE.prec",paste('FDR',1:length(output$qvalue), sep=''))
  #row.names(res) = 1
  
  #return(t(data.frame(FDR)))
  #return(c(list(MSE=MSE), FDR))
  #return(list(MSE=MSE,FDR=FDR))
  return(res)
}
