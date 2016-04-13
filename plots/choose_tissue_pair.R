#############################################################
# List the top tissue pair comparisons that vash gets higher likelihoods than 
# limma (or vash with single component IG prior)
#############################################################
# rearrage the results data frame
load("../code/dsc-gtex-vash/res_scaled.Rdata")
library(tidyr)
test = spread(res[,3:5], key=method, value=loglike)
test = test[,c(1,2,4,3,5)]
names(test)=c("scenario","limma","vash.sing","vash.prec","vash.var")
maxloglike=c("limma","vash.sing","vash.prec","vash.var")[apply(test[,2:5],1,which.max)]
test = cbind(test,maxloglike)

# summary stats of the log-likelihood differences between vash & limma (or vash w. single component prior)
summary((pmax(test$vash.prec,test$vash.var)-test$limma)>0)
summary((pmax(test$vash.prec,test$vash.var)-test$vash.sing)>0)

# list the top 10 tissue pair comparisons that vash overperforms limma
diff = (pmax(test$vash.prec,test$vash.var)-test$vash.sing)
test[order(diff,decreasing = TRUE)[1:10],]

#############################################
# Plot Figure 3: 
# The variance priors (top row) and precision priors (bottom row) 
# fitted by mixture prior model (black line) or single component prior model (red line) 
# for 6 tissue pair comparisons. 
# The differences in the log-likelihood between the mixture prior model 
# and the single component prior model are given by 705, 166, 78, 78, 44, 44 
# respectively (from left to right).
##############################################

# Function to compute the density of mixture inverse-gamma prior
# alpha: vector of shape
# beta: vector of rate
# pi: vector of mixture proportion
# xmax: compute density on (0,xmax)
Gammaprior2 = function(alpha,beta,pi,xmax){
  xgrid=seq(min(1e-5,xmax/1000),xmax,by=xmax/1000)
  EBprior.var.sep=dgamma(outer(1/xgrid,rep(1,length(alpha))),
                         shape=outer(rep(1,length(xgrid)),alpha),
                         rate=outer(rep(1,length(xgrid)),beta))*outer(1/xgrid^2,rep(1,length(alpha)))
  EBprior.var=rowSums(outer(rep(1,length(xgrid)),pi)*EBprior.var.sep)
  EBprior.prec.sep=dgamma(outer(xgrid,rep(1,length(alpha))),
                          shape=outer(rep(1,length(xgrid)),alpha),
                          rate=outer(rep(1,length(xgrid)),beta))                    
  EBprior.prec=rowSums(outer(rep(1,length(xgrid)),pi)*EBprior.prec.sep)
  
  if(min(alpha)>1){
    xgrid=c(0,xgrid)
    EBprior.var=c(0,EBprior.var)
    EBprior.prec=c(0,EBprior.prec)
  }
  
  return(list(xgrid=xgrid,EBprior.var=EBprior.var,EBprior.prec=EBprior.prec, 
              EBpriorvar.sep=EBprior.var.sep, EBprior.prec.sep=EBprior.prec.sep))
}

# plot the fitted priors of a tissue pair comparison
plotpriors = function(tissue1, tissue2){
  out.prec = readRDS(paste0("../code/dsc-gtex-vash/dsc-gtex-files/output/",tissue1,",",tissue2,"/voom+vash.prec/vash_output/output.1.rds"))
  out.var = readRDS(paste0("../code/dsc-gtex-vash/dsc-gtex-files/output/",tissue1,",",tissue2,"/voom+vash.var/vash_output/output.1.rds"))
  out.sing = readRDS(paste0("../code/dsc-gtex-vash/dsc-gtex-files/output/",tissue1,",",tissue2,"/voom+vash.sing/vash_output/output.1.rds"))
  
  if (out.prec$fit$loglik <= out.var$fit$loglik){
    out.mix = out.var
  }else{
    out.mix = out.prec
  }
  temp.mix = Gammaprior2(out.mix$fitted.g$alpha,out.mix$fitted.g$beta,out.mix$fitted.g$pi,xmax=5)
  temp.sing = Gammaprior2(out.sing$fitted.g$alpha,out.sing$fitted.g$beta,out.sing$fitted.g$pi,xmax=5)
  
  plot(temp.mix$xgrid, temp.mix$EBprior.prec, type='l',
       main=paste(tissue1,"\n vs. \n",tissue2),xlab='x',
       cex.axis=1.3, cex.main=1.1,
       ylim=c(0,max(c(temp.mix$EBprior.prec,temp.sing$EBprior.prec))))
  lines(temp.sing$xgrid, temp.sing$EBprior.prec, col=2)
  legend("topright",col=c(1,2),lty=c(1,1),legend=c("Mixture","Single"),cex=1.2)
  
  plot(temp.mix$xgrid, temp.mix$EBprior.var, type='l',
       main=paste(tissue1,"\n vs. \n",tissue2), xlab='x',
       cex.axis=1.3, cex.main=1.1,
       ylim=c(0,max(c(temp.mix$EBprior.var,temp.sing$EBprior.var))))
  lines(temp.sing$xgrid, temp.sing$EBprior.var, col=2)
  legend("topright",col=c(1,2),lty=c(1,1),legend=c("Mixture","Single"),cex=1.2)
}

# plot Figure 3
setEPS()
postscript("../paper/tissuepairs.eps",width=7.5,height=10)
par(mfcol=c(4,3),
    oma = c(0, 2, 0, 0), # two rows of text at the outer left and bottom margin
    mar = c(2, 2, 6, 1), # space for one row of text at ticks and to separate plots
    mgp = c(2, 1, 0))
# Max log-likelihood difference (unimodal precision prior): Cervix-Ectocervix,Testis
plotpriors("Cervix-Ectocervix","Testis")
# Max log-likelihood difference (unimodal variance prior): Brain-Amygdala,Brain-Cerebellum
plotpriors("Brain-Amygdala","Brain-Cerebellum")
# 90% log-likelihood difference (unimodal precision prior): Brain-Anteriorcingulatecortex(BA24),Cervix-Endocervix
plotpriors("Brain-Anteriorcingulatecortex(BA24)","Cervix-Endocervix")
# 90% log-likelihood difference (unimodal variance prior): Brain-CerebellarHemisphere,Stomach
plotpriors("Brain-CerebellarHemisphere","Stomach")
# 75% log-likelihood difference (unimodal precision prior): FallopianTube,Skin-NotSunExposed(Suprapubic)
plotpriors("FallopianTube","Skin-NotSunExposed(Suprapubic)")
# 75% log-likelihood difference (unimodal variance prior): AdrenalGland,Stomach
plotpriors("AdrenalGland","Stomach")

mtext('precision prior density', side=2, outer=TRUE,adj=0.5, cex=0.9, line=0.5,
      at= grconvertY(3.4, from='nfc', to='ndc'))
mtext('variance prior density', side=2, outer=TRUE,adj=0.5,cex=0.9,line=0.5,
      at= grconvertY(2.4, from='nfc', to='ndc'))
mtext('precision prior density', side=2, outer=TRUE,adj=0.5,cex=0.9,line=0.5,
      at= grconvertY(1.4, from='nfc', to='ndc'))
mtext('variance prior density', side=2, outer=TRUE,adj=0.5,cex=0.9,line=0.5,
      at= grconvertY(0.4, from='nfc', to='ndc'))
dev.off()