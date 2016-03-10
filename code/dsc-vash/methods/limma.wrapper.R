# Moderated t-test (Smyth, 2005)
# Using R package "limma"
# input: Y - data matrix such that samplemean=betahat, sd(samplemean)=sebetahat
library(limma)
library(qvalue)

limma.wrapper = function(input,args){
  fit = lmFit(input$Y, rep(1,dim(input$Y)[2]))
  fit = eBayes(fit, robust=args$robust)
  #qvalue = qvalue(fit$p.value)$qval
  # return estimates of variance, and q-values for testing beta=0
  return(fit)
}

limma_loglike = function(fit){
  c = fit$df.prior/(fit$stdev.unscaled^2*fit$s2.prior*(fit$df.prior+2))
  n = length(fit$p.value)
  alpha = fit$df.prior/2
  v = fit$df.residual
  sehat = fit$sigma*fit$stdev.unscaled
  loglike = loglike.singleIG(c,n,alpha,v,sehat)
  return(loglike)
}


# Log-likelihood: L(sehat^2|hyperparams)
loglike.singleIG = function(c,n,alpha,v,sehat){  
  likelihood = exp(v/2*log(v/2)-lgamma(v/2)+(v/2-1)*2*log(sehat)
                                 +alpha*log(c*(alpha+1))-lgamma(alpha)+lgamma(alpha+v/2)
                                 -(alpha+v/2)*log(v/2*sehat^2+c*(alpha+1)))
  logl = sum(log(likelihood))
  return(logl)
}