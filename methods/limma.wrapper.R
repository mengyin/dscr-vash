# Moderated t-test (Smyth, 2005)
# Using R package "glmnet"
# input: Y - data matrix such that samplemean=betahat, sd(samplemean)=sebetahat
limma.wrapper = function(input,args){
  library(limma)
  library(qvalue)
  fit = lmFit(input$Y, rep(1,dim(input$Y)[2]))
  fit = eBayes(fit, robust=args$robust)
  qvalue = qvalue(fit$p.value)$qval
  # return estimates of variance, and q-values for testing beta=0
  return(list(s2.est = fit$s2.post*fit$stdev.unscaled^2,
              qvalue = qvalue))
}
