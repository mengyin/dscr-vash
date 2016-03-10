# Variance adaptive shrinkage (vash)
# Using R package "vash"
# input: betahat - estimate of effect size
#        sebetahat - estimated sd of betahat

library(vash)
library(limma)
vash.wrapper = function(input,args){
   
  if (args$transform=="voom"){
    lim = lmFit(input$v)
    betahat = input$betahat.voom
    sebetahat = input$sebetahat.voom/lim$stdev.unscaled[,2]
    df = input$df.voom
  }else if (args$transform=="quasibinom"){
    betahat = input$betahat.qb
    sebetahat = input$sebetahat.qb
    df = input$df.qb
  }else if (args$transform=="Myrna+quasibinom"){
    betahat = input$betahat.Myrnaqb
    sebetahat = input$sebetahat.Myrnaqb
    df = input$df.Myrnaqb
  }else if (args$transform=="Myrnaoff+quasibinom"){
    betahat = input$betahat.Myrnaoffqb
    sebetahat = input$sebetahat.Myrnaoffqb
    df = input$df.Myrnaoffqb
  }else if (args$transform=="RUV+quasibinom"){
    betahat = input$betahat.RUVqb
    sebetahat = input$sebetahat.RUVqb
    df = input$df.RUVqb
  }else if (args$transform=="SVA+quasibinom"){
    betahat = input$betahat.SVAqb
    sebetahat = input$sebetahat.SVAqb
    df = input$df.SVAqb
  }else if (args$transform=="edgeRglm"){
    betahat = input$betahat.edgeRglm
    sebetahat = input$sebetahat.edgeRglm
    df = input$df.edgeRglm
  }else if (args$transform=="DESeqglm"){
    betahat = input$betahat.DESeqglm
    sebetahat = input$sebetahat.DESeqglm
    df = input$df.DESeqglm
  }
  
  fit = vash(sehat=sebetahat,df=df,unimodal=args$unimodal,singlecomp=args$singlecomp)
  return(fit)
}