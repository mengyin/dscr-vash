# Variance adaptive shrinkage (vash)
# Using R package "vash"
# input: betahat - estimate of effect size
#        sebetahat - estimated sd of betahat
vashopt.wrapper = function(input,args){
  library(vash)
  
  # Try both unimodal precision prior or unimodal variance prior
  fit1 = do.call(vash, args=c(list(sehat=input$sebetahat,
                                   df=input$df,
                                   betahat=input$betahat,
                                   unimodal='precision'),args))
  fit2 = do.call(vash, args=c(list(sehat=input$sebetahat,
                                   df=input$df,
                                   betahat=input$betahat,
                                   unimodal='variance'),args))
  
  # Choose the one with higher log-likelihood
  if (fit1$fit$loglik >= fit2$fit$loglik){
    fit = fit1
  }else{
    fit = fit2
  }
  return(fit)
}