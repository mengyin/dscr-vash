# Variance adaptive shrinkage (vash)
# Using R package "vash"
# input: betahat - estimate of effect size
#        sebetahat - estimated sd of betahat
vash.wrapper = function(input,args){
  library(vash)
  library(qvalue)
  fit = vash(input$sebetahat,input$df,input$betahat,unimodal=input$unimodal,
             singlecomp=args$singlecomp)
  qvalue = qvalue(fit$pvalue)$qval
  # return estimates of variance, and q-values for testing beta=0
  return(list(s2.est = fit$PosteriorMean^2,
              qvalue = qvalue))
}