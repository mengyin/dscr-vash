# Variance adaptive shrinkage (vash)
# Using R package "vash"
# input: betahat - estimate of effect size
#        sebetahat - estimated sd of betahat
vash.wrapper = function(input,args){
  library(vash)
  fit = do.call(vash, args=c(list(sehat=input$sebetahat,df=input$df,betahat=input$betahat),args))
  return(fit)
}