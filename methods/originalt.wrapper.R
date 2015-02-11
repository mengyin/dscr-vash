# Orignial t-test
# input: betahat - estimate of effect size
#        sebetahat - estimated sd of betahat
originalt.wrapper = function(input,args){
  library(qvalue)
  
  pvalue = 2*pt(abs(input$betahat/input$sebetahat),df=input$df,lower.tail=FALSE)
  qvalue = qvalue(pvalue)$qval
  # return estimates of variance, and q-values for testing beta=0
  return(list(s2.est = input$sebetahat^2,
              qvalue = qvalue))
}