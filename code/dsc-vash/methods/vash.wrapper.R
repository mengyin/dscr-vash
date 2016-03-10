# Variance adaptive shrinkage (vash)
# Using R package "vashr"
# input: betahat - estimate of effect size
#        sebetahat - estimated sd of betahat

library(vashr)
vash.wrapper = function(input,args){
  fit = do.call(vash, args=c(list(sehat=input$sebetahat,df=input$df,betahat=input$betahat),args))
  return(fit)
}