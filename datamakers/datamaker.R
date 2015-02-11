# Simulate data:
#    truese^2~mixture with unimode c
# or 1/truese^2~mixture with unimode 1/c
# (variances' mixture distribution type: inverse-gamma or log-normal)
# sebetahat^2/(truevar*df) ~ Chisq distn with degree of freedom df
# Null: truemean=0
# Alternative: truemean~N(0,altsd^2)
# betahat ~ N(truemean, sebetahat^2)
# Y: data matrix such that samplemean=betahat, sd(samplemean)=sebetahat
datamaker = function(seed,args){
  library(MASS)
  set.seed(seed)
  
  N = args$N
  Nnull = args$Nnull
  altmean = args$altmean
  altsd = args$altsd
  df = args$df 
  pi = args$pi
  c = args$c
  unimodal = args$unimodal
  priortype = args$priortype
  
  # Simulate truese
  K = length(pi)
  ind = t(rmultinom(N, 1, pi))
  
  if(priortype=='inversegamma'){
    alpha = args$alpha
    lnsd = NULL
    if(unimodal=='variance'){
      # variance distn is unimodal on c
      modalpha = alpha+1
      truevar = 1/rgamma(N*K,shape=rep(alpha,each=N),rate=rep(modalpha*c,each=N))
      truevar = apply(ind*matrix(truevar,ncol=K),1,sum)
    }else if(unimodal=='precision'){
      # precision distn is unimodal on 1/c
      modalpha = alpha-1
      truevar = 1/rgamma(N*K,shape=rep(alpha,each=N),rate=rep(modalpha*c,each=N))
      truevar = apply(ind*matrix(truevar,ncol=K),1,sum)
    }
  }else if(priortype=='lognormal'){
    lnsd = args$lnsd
    alpha = NULL
    if(unimodal=='variance'){
      truevar=rlnorm(N*K,mean=rep(log(c)+lnsd^2,each=N),sd=rep(lnsd,each=N))
      truevar=apply(ind*matrix(truevar,ncol=K),1,sum)
    }else if(unimodal=='precision'){ 
      # precision distn is unimodal on 1/c
      truevar=1/rlnorm(N*K,mean=rep(-log(c)+lnsd^2,each=N),sd=rep(lnsd,each=N))
      truevar=apply(ind*matrix(truevar,ncol=K),1,sum)
    }
  }
  
  truese = sqrt(truevar)
  
  # Simulate truemean
  null = c(rep(1, Nnull), rep(0, N - Nnull))
  truemean = c(rep(0,Nnull),rnorm(N-Nnull,mean=altmean,sd=altsd))
  
  # Simulate data matrix Y
  Y = matrix(rnorm(N*(df+1),mean=rep(truemean,df+1),sd=rep(sqrt(truevar*(df+1)),df+1)),ncol=df+1)
  sebetahat = sqrt(apply(Y,1,var)/(df+1))
  betahat = apply(Y,1,mean)
  
  # meta data
  meta = list(truemean=truemean, truese=truese, null=null,
              pi=pi, c=c, alpha=alpha, lnsd=lnsd)
  
  # input data
  input = list(betahat=betahat, sebetahat=sebetahat, Y=Y, 
               df=df, unimodal=unimodal)
  
  data = list(meta=meta,input=input)
  return(data)
}
