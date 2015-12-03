# limma+ash
# input: Y - data matrix such that samplemean=betahat, sd(samplemean)=sebetahat
library(limma)
library(qvalue)
library(ashr)
limma_ash.wrapper = function(input,args){
  
  lmfit = lmFit(input$Y, rep(1,dim(input$Y)[2]))
  lmfit = eBayes(lmfit)
  fit = do.call(ash, args= c(list(betahat=input$betahat,
                                  sebetahat=sqrt(lmfit$s2.post)*lmfit$stdev.unscaled, 
                                  df = lmfit$df.total[1]),args))
  # return estimates of variance, and q-values for testing beta=0
  return(list(fit=fit))
}