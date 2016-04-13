#################################################
# Plot Figure 1 & 2: 
# RRMSEs of scenarios A-H defined in Table 1 & 2
#################################################

# Function to compute the density of mixture inverse-gamma prior
# alpha: vector of shape
# c: mode
# pi: vector of mixture proportion
# unimodal: whether unimodal on variance or on precision
# xmax: compute density on (0,xmax)
Gammaprior=function(alpha,c,pi,unimodal,xmax){
  xgrid=seq(0.0001,xmax,by=0.01)
  if(unimodal=='variance'){
    EBprior.var.sep=dgamma(outer(1/xgrid,rep(1,length(alpha))),
                           shape=outer(rep(1,length(xgrid)),alpha),
                           rate=c*outer(rep(1,length(xgrid)),alpha+1))*outer(1/xgrid^2,rep(1,length(alpha)))
    EBprior.var=rowSums(outer(rep(1,length(xgrid)),pi)*EBprior.var.sep)
    EBprior.prec.sep=dgamma(outer(xgrid,rep(1,length(alpha))),
                            shape=outer(rep(1,length(xgrid)),alpha),
                            rate=c*outer(rep(1,length(xgrid)),alpha+1))                    
    EBprior.prec=rowSums(outer(rep(1,length(xgrid)),pi)*EBprior.prec.sep)
  }else if (unimodal=='precision'){
    EBprior.var.sep=dgamma(outer(1/xgrid,rep(1,length(alpha))),
                           shape=outer(rep(1,length(xgrid)),alpha),
                           rate=c*outer(rep(1,length(xgrid)),alpha-1))*outer(1/xgrid^2,rep(1,length(alpha)))
    EBprior.var=rowSums(outer(rep(1,length(xgrid)),pi)*EBprior.var.sep)
    EBprior.prec.sep=dgamma(outer(xgrid,rep(1,length(alpha))),
                            shape=outer(rep(1,length(xgrid)),alpha),
                            rate=c*outer(rep(1,length(xgrid)),alpha-1))                   
    EBprior.prec=rowSums(outer(rep(1,length(xgrid)),pi)*EBprior.prec.sep)
  }
  return(list(xgrid=xgrid,EBprior.var=EBprior.var,EBprior.prec=EBprior.prec, 
              EBpriorvar.sep=EBprior.var.sep, EBprior.prec.sep=EBprior.prec.sep))
}

# Function to compute the density of mixture log-normal prior
# lnsd: vector of sd
# c: mode
# pi: vector of mixture proportion
# unimodal: whether unimodal on variance or on precision
# xmax: compute density on (0,xmax)
logNprior=function(lnsd,c,pi,unimodal,xmax){
  xgrid=seq(0.0001,xmax,by=0.01)
  if(unimodal=='variance'){
    EBprior.var.sep=dlnorm(outer(xgrid,rep(1,length(lnsd))),
                           mean=outer(rep(1,length(xgrid)),log(c)+lnsd^2),
                           sd=outer(rep(1,length(xgrid)),lnsd))
    EBprior.var=rowSums(outer(rep(1,length(xgrid)),pi)*EBprior.var.sep)
    EBprior.prec.sep=dlnorm(outer(xgrid,rep(1,length(lnsd))),
                            mean=outer(rep(1,length(xgrid)),-(log(c)+lnsd^2)),
                            sd=outer(rep(1,length(xgrid)),lnsd))                    
    EBprior.prec=rowSums(outer(rep(1,length(xgrid)),pi)*EBprior.prec.sep)
  }else if (unimodal=='precision'){
    EBprior.var.sep=dlnorm(outer(xgrid,rep(1,length(lnsd))),
                           mean=outer(rep(1,length(xgrid)),log(c)-lnsd^2),
                           sd=outer(rep(1,length(xgrid)),lnsd))
    EBprior.var=rowSums(outer(rep(1,length(xgrid)),pi)*EBprior.var.sep)
    EBprior.prec.sep=dlnorm(outer(xgrid,rep(1,length(lnsd))),
                            mean=outer(rep(1,length(xgrid)),-log(c)+lnsd^2),
                            sd=outer(rep(1,length(xgrid)),lnsd))            
    EBprior.prec=rowSums(outer(rep(1,length(xgrid)),pi)*EBprior.prec.sep)
  }
  return(list(xgrid=xgrid,EBprior.var=EBprior.var,EBprior.prec=EBprior.prec, 
              EBpriorvar.sep=EBprior.var.sep, EBprior.prec.sep=EBprior.prec.sep))
}

# rearrage the results data frame and compute RRMSEs
library(dplyr)
load("../code/dsc-vash/res.Rdata")
newres = res
newres = newres[newres$method=='baseline',]
newres = newres[c(2,3,5,6)]
names(newres)[c(3,4)] = c('RMSE.prec_baseline','RMSE.var_baseline')
test = left_join(res,newres,by=c('seed','scenario'))
test$RMSE.prec_rel = test$RMSE.prec/test$RMSE.prec_baseline # RRMSE_prec
test$RMSE.var_rel = test$RMSE.var/test$RMSE.var_baseline # RRMSE_var

# plot Figure 1
setEPS()
postscript('../paper/relmse_var.eps',width=10,height=10)

par(mfrow = c(4, 4),     
    oma = c(0, 2, 0, 0), # two rows of text at the outer left and bottom margin
    mar = c(2, 2, 4, 1), # space for one row of text at ticks and to separate plots
    mgp = c(2, 1, 0))

temp=Gammaprior(alpha=10,c=1,pi=1,unimodal='variance',xmax=5)
plot(temp$xgrid, temp$EBprior.var, type='l',ylim=c(0,1.5),
     main='(A) Variance Prior:\n single IG',xlab='x',cex.main=1.8,cex.axis=1.45)

temp=Gammaprior(alpha=c(3,10),c=1,pi=c(0.1,0.9),unimodal='variance',xmax=5)
plot(temp$xgrid, temp$EBprior.var, type='l', ylim=c(0,1.5),
     main='(B) Variance Prior:\n single IG with outliers',xlab='x',cex.main=1.8,cex.axis=1.45)

temp=Gammaprior(alpha=c(3,5,20),c=1,pi=c(0.1,0.4,0.5),unimodal='variance',xmax=5)
plot(temp$xgrid, temp$EBprior.var, type='l',ylim=c(0,1.5),
     main='(C) Variance Prior:\n IG mixture',xlab='x',cex.main=1.8,cex.axis=1.45)

temp=logNprior(lnsd=c(0.25,0.8),c=1,pi=c(0.7,0.3),unimodal='variance',xmax=5)
plot(temp$xgrid, temp$EBprior.var, type='l',ylim=c(0,1.5),
     main='(D) Variance Prior:\n log-normal mixture',xlab='x',cex.main=1.8,cex.axis=1.45)

idx1 = (res[,3]=="A,df=3" & res[,4]=="vash.opt")
idx2 = (res[,3]=="A,df=3" & res[,4]=="limma")
idx3 = (res[,3]=="A,df=3" & res[,4]=="limmaR")
boxplot(test$RMSE.var_rel[idx1], test$RMSE.var_rel[idx2], test$RMSE.var_rel[idx3],ylim=c(0.3,0.8),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=3',cex.main=1.8)

idx1 = (res[,3]=="B,df=3" & res[,4]=="vash.opt")
idx2 = (res[,3]=="B,df=3" & res[,4]=="limma")
idx3 = (res[,3]=="B,df=3" & res[,4]=="limmaR")
boxplot(test$RMSE.var_rel[idx1], test$RMSE.var_rel[idx2], test$RMSE.var_rel[idx3],ylim=c(0.3,0.8),
        names=c("vash", "limma", "limmaR"), col="grey",  colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=3',cex.main=1.8)

idx1 = (res[,3]=="C,df=3" & res[,4]=="vash.opt")
idx2 = (res[,3]=="C,df=3" & res[,4]=="limma")
idx3 = (res[,3]=="C,df=3" & res[,4]=="limmaR")
boxplot(test$RMSE.var_rel[idx1], test$RMSE.var_rel[idx2], test$RMSE.var_rel[idx3],ylim=c(0.3,0.8),
        names=c("vash", "limma", "limmaR"), col="grey",  colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=3',cex.main=1.8)

idx1 = (res[,3]=="D,df=3" & res[,4]=="vash.opt")
idx2 = (res[,3]=="D,df=3" & res[,4]=="limma")
idx3 = (res[,3]=="D,df=3" & res[,4]=="limmaR")
boxplot(test$RMSE.var_rel[idx1], test$RMSE.var_rel[idx2], test$RMSE.var_rel[idx3],ylim=c(0.3,0.8),
        names=c("vash", "limma", "limmaR"), col="grey",  colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=3',cex.main=1.8)

idx1 = (res[,3]=="A,df=10" & res[,4]=="vash.opt")
idx2 = (res[,3]=="A,df=10" & res[,4]=="limma")
idx3 = (res[,3]=="A,df=10" & res[,4]=="limmaR")
boxplot(test$RMSE.var_rel[idx1], test$RMSE.var_rel[idx2], test$RMSE.var_rel[idx3],ylim=c(0.5,1),
        names=c("vash", "limma", "limmaR"), col="grey",  colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=10',cex.main=1.8)
abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="B,df=10" & res[,4]=="vash.opt")
idx2 = (res[,3]=="B,df=10" & res[,4]=="limma")
idx3 = (res[,3]=="B,df=10" & res[,4]=="limmaR")
boxplot(test$RMSE.var_rel[idx1], test$RMSE.var_rel[idx2], test$RMSE.var_rel[idx3],ylim=c(0.5,1),
        names=c("vash", "limma", "limmaR"), col="grey",  colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=10',cex.main=1.8)
abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="C,df=10" & res[,4]=="vash.opt")
idx2 = (res[,3]=="C,df=10" & res[,4]=="limma")
idx3 = (res[,3]=="C,df=10" & res[,4]=="limmaR")
boxplot(test$RMSE.var_rel[idx1], test$RMSE.var_rel[idx2], test$RMSE.var_rel[idx3],ylim=c(0.5,1),
        names=c("vash", "limma", "limmaR"), col="grey",  colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=10',cex.main=1.8)
abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="D,df=10" & res[,4]=="vash.opt")
idx2 = (res[,3]=="D,df=10" & res[,4]=="limma")
idx3 = (res[,3]=="D,df=10" & res[,4]=="limmaR")
boxplot(test$RMSE.var_rel[idx1], test$RMSE.var_rel[idx2], test$RMSE.var_rel[idx3],ylim=c(0.5,1),
        names=c("vash", "limma", "limmaR"), col="grey",  colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=10',cex.main=1.8)
abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="A,df=50" & res[,4]=="vash.opt")
idx2 = (res[,3]=="A,df=50" & res[,4]=="limma")
idx3 = (res[,3]=="A,df=50" & res[,4]=="limmaR")
boxplot(test$RMSE.var_rel[idx1], test$RMSE.var_rel[idx2], test$RMSE.var_rel[idx3],ylim=c(0.8,1.1),
        names=c("vash", "limma", "limmaR"), col="grey",  colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=50',cex.main=1.8)
abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="B,df=50" & res[,4]=="vash.opt")
idx2 = (res[,3]=="B,df=50" & res[,4]=="limma")
idx3 = (res[,3]=="B,df=50" & res[,4]=="limmaR")
boxplot(test$RMSE.var_rel[idx1], test$RMSE.var_rel[idx2], test$RMSE.var_rel[idx3],ylim=c(0.8,1.1),
        names=c("vash", "limma", "limmaR"), col="grey",  colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=50',cex.main=1.8)
abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="C,df=50" & res[,4]=="vash.opt")
idx2 = (res[,3]=="C,df=50" & res[,4]=="limma")
idx3 = (res[,3]=="C,df=50" & res[,4]=="limmaR")
boxplot(test$RMSE.var_rel[idx1], test$RMSE.var_rel[idx2], test$RMSE.var_rel[idx3],ylim=c(0.8,1.1),
        names=c("vash", "limma", "limmaR"), col="grey",  colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=50',cex.main=1.8)
abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="D,df=50" & res[,4]=="vash.opt")
idx2 = (res[,3]=="D,df=50" & res[,4]=="limma")
idx3 = (res[,3]=="D,df=50" & res[,4]=="limmaR")
boxplot(test$RMSE.var_rel[idx1], test$RMSE.var_rel[idx2], test$RMSE.var_rel[idx3],ylim=c(0.8,1.1),
        names=c("vash", "limma", "limmaR"), col="grey",  colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=50',cex.main=1.8)
abline(h=1,lty=2,col=2)

mtext('density', side=2, outer=TRUE,adj=0.5, cex=1.1, line=0.5,
      at= grconvertY(3.5, from='nfc', to='ndc'))
mtext('RRMSE', side=2, outer=TRUE,adj=0.5,cex=1.1,line=0.5,
      at= grconvertY(2.5, from='nfc', to='ndc'))
mtext('RRMSE', side=2, outer=TRUE,adj=0.5,cex=1.1,line=0.5,
      at= grconvertY(1.5, from='nfc', to='ndc'))
mtext('RRMSE', side=2, outer=TRUE,adj=0.5,cex=1.1,line=0.5,
      at= grconvertY(0.5, from='nfc', to='ndc'))
dev.off()

# plot Figure 2
setEPS()
postscript("../paper/relmse2_prec.eps",width=10,height=10)

par(mfrow = c(4, 4),     
    oma = c(0, 2, 0, 0), # two rows of text at the outer left and bottom margin
    mar = c(2, 2, 4, 1), # space for one row of text at ticks and to separate plots
    mgp = c(2, 1, 0))

temp=Gammaprior(alpha=10,c=1,pi=1,unimodal='precision',xmax=5)
plot(temp$xgrid, temp$EBprior.prec, type='l',ylim=c(0,1.5),
     main='(E) Precision Prior:\n single gamma',xlab='x',cex.main=1.8,cex.axis=1.45)

temp=Gammaprior(alpha=c(2,10),c=1,pi=c(0.1,0.9),unimodal='precision',xmax=5)
plot(temp$xgrid, temp$EBprior.prec, type='l', ylim=c(0,1.5),
     main='(F) Precision Prior:\n single gamma w/ outliers',xlab='x',cex.main=1.8,cex.axis=1.45)

temp=Gammaprior(alpha=c(2,5,30),c=1,pi=c(0.1,0.4,0.5),unimodal='precision',xmax=5)
plot(temp$xgrid, temp$EBprior.prec, type='l',ylim=c(0,1.5),
     main='(G) Precision Prior:\n gamma mixture',xlab='x',cex.main=1.8,cex.axis=1.45)

temp=logNprior(lnsd=c(0.25,0.8),c=1,pi=c(0.7,0.3),unimodal='precision',xmax=5)
plot(temp$xgrid, temp$EBprior.prec, type='l',ylim=c(0,1.5),
     main='(H) Precision Prior:\n log-normal mixture',xlab='x',cex.main=1.8,cex.axis=1.45)

idx1 = (res[,3]=="E,df=3" & res[,4]=="vash.opt")
idx2 = (res[,3]=="E,df=3" & res[,4]=="limma")
idx3 = (res[,3]=="E,df=3" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0,0.1),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=3',cex.main=1.8)

idx1 = (res[,3]=="F,df=3" & res[,4]=="vash.opt")
idx2 = (res[,3]=="F,df=3" & res[,4]=="limma")
idx3 = (res[,3]=="F,df=3" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0,0.1),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=3',cex.main=1.8)

idx1 = (res[,3]=="G,df=3" & res[,4]=="vash.opt")
idx2 = (res[,3]=="G,df=3" & res[,4]=="limma")
idx3 = (res[,3]=="G,df=3" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0,0.1),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=3',cex.main=1.8)

idx1 = (res[,3]=="H,df=3" & res[,4]=="vash.opt")
idx2 = (res[,3]=="H,df=3" & res[,4]=="limma")
idx3 = (res[,3]=="H,df=3" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0,0.1),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=3',cex.main=1.8)

idx1 = (res[,3]=="E,df=10" & res[,4]=="vash.opt")
idx2 = (res[,3]=="E,df=10" & res[,4]=="limma")
idx3 = (res[,3]=="E,df=10" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.3,0.8),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=10',cex.main=1.8)

idx1 = (res[,3]=="F,df=10" & res[,4]=="vash.opt")
idx2 = (res[,3]=="F,df=10" & res[,4]=="limma")
idx3 = (res[,3]=="F,df=10" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.3,0.8),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=10',cex.main=1.8)

idx1 = (res[,3]=="G,df=10" & res[,4]=="vash.opt")
idx2 = (res[,3]=="G,df=10" & res[,4]=="limma")
idx3 = (res[,3]=="G,df=10" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.3,0.8),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=10',cex.main=1.8)

idx1 = (res[,3]=="H,df=10" & res[,4]=="vash.opt")
idx2 = (res[,3]=="H,df=10" & res[,4]=="limma")
idx3 = (res[,3]=="H,df=10" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.3,0.8),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=10',cex.main=1.8)

idx1 = (res[,3]=="E,df=50" & res[,4]=="vash.opt")
idx2 = (res[,3]=="E,df=50" & res[,4]=="limma")
idx3 = (res[,3]=="E,df=50" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.7,1.5),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=50',cex.main=1.8)
abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="F,df=50" & res[,4]=="vash.opt")
idx2 = (res[,3]=="F,df=50" & res[,4]=="limma")
idx3 = (res[,3]=="F,df=50" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.7,1.5),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=50',cex.main=1.8)
abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="G,df=50" & res[,4]=="vash.opt")
idx2 = (res[,3]=="G,df=50" & res[,4]=="limma")
idx3 = (res[,3]=="G,df=50" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.7,1.5),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=50',cex.main=1.8)
abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="H,df=50" & res[,4]=="vash.opt")
idx2 = (res[,3]=="H,df=50" & res[,4]=="limma")
idx3 = (res[,3]=="H,df=50" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.7,1.5),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black",cex.axis=1.45,xaxt="n")
axis(1,at=1:3,labels=FALSE)
text(x=1:3, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),
     labels=c("vash", "limma", "limmaR"), cex=1.75, xpd=TRUE)
title('df=50',cex.main=1.8)
abline(h=1,lty=2,col=2)

mtext('density', side=2, outer=TRUE,adj=0.5, cex=1.1, line=0.5,
      at= grconvertY(3.5, from='nfc', to='ndc'))
mtext('RRMSE', side=2, outer=TRUE,adj=0.5,cex=1.1,line=0.5,
      at= grconvertY(2.5, from='nfc', to='ndc'))
mtext('RRMSE', side=2, outer=TRUE,adj=0.5,cex=1.1,line=0.5,
      at= grconvertY(1.5, from='nfc', to='ndc'))
mtext('RRMSE', side=2, outer=TRUE,adj=0.5,cex=1.1,line=0.5,
      at= grconvertY(0.5, from='nfc', to='ndc'))
dev.off()