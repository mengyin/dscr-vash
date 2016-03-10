# Moderated t-test (Smyth, 2005)
# Using R package "limma"
# input: Y - data matrix such that samplemean=betahat, sd(samplemean)=sebetahat

library(limma)
library(qvalue)

limma.wrapper = function(input,args){
  if (args$transform=="voom"){
    fit = lmFit(input$v)
    fit = eBayes(fit)
  }else if (args$transform=="quasibinom"){
    #fit = lmFit(input$Y, rep(1,dim(input$Y)[2]))
    stop("Cannot use limma to analyze the input.")
  }
    
  loglik = loglike(input$sebetahat.voom/fit$stdev.unscaled[,2], input$df.voom, 1, 
                   fit$df.prior/2, 1/fit$s2.prior)
  return(list(loglike=loglik))
}

loglike = function(sehat,df,pi,alpha,beta){
  k = length(pi)
  n = length(sehat)
  
  pimat = outer(rep(1,n),pi)*exp(df/2*log(df/2)-lgamma(df/2)
                                 +(df/2-1)*outer(2*log(sehat),rep(1,k))
                                 +outer(rep(1,n),alpha*log(beta)-lgamma(alpha)+lgamma(alpha+df/2))
                                 -outer(rep(1,n),alpha+df/2)*log(outer(df/2*sehat^2,beta,FUN="+")))
  logl = sum(log(rowSums(pimat)))
  return(logl)
}
