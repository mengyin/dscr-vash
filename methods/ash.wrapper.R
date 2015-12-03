# input: betahat - estimate of effect size
#        sebetahat - estimated sd of betahat
ash.wrapper = function(input,args){
  library(ashr)
  library(qvalue)
  
  fit = ash(input$betahat,input$sebetahat,df=input$df,
            method="fdr",
            mixcompdist=args$mixcompdist)
  #qvalue = fit$qvalue
  # return estimates of beta, and q-values for testing beta=0
  #return(list(qvalue = qvalue, qvalue.fsr = qval.from.lfdr(fit$lfsr)))
  return(list(fit=fit))
}