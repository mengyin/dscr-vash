#############################################################
# Plot Figure 4: 
# RRMSEs of scenarios simulated from GTEx tissue comparisons
#############################################################
# rearrage the results data frame and compute RRMSEs
load("../code/dsc-vash/res_appli.Rdata")

library(dplyr)
newres=res
newres=newres[newres$method=='baseline',]
newres=newres[c(2,3,5,6)]
names(newres)[c(3,4)] = c('RMSE.prec_baseline','RMSE.var_baseline')
test=left_join(res,newres,by=c('seed','scenario'))
test$RMSE.prec_rel = test$RMSE.prec/test$RMSE.prec_baseline # RRMSE_prec
test$RMSE.var_rel = test$RMSE.var/test$RMSE.var_baseline # RRMSE_var

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

# plot Figure 4
setEPS()
postscript("../paper/rmse_gtex.eps",width=10,height=7.5)
par(mfcol=c(3,4))

idx1 = (res[,3]=="gtex90.prec,df=3" & res[,4]=="vash.opt")
idx2 = (res[,3]=="gtex90.prec,df=3" & res[,4]=="limma")
idx3 = (res[,3]=="gtex90.prec,df=3" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0,.15),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black")
title('Brain-Anteriorcingulatecortex(BA24) vs.\n Cervix-Endocervix,\n df=3',ylab='Precision RRMSE')
#abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="gtex90.prec,df=10" & res[,4]=="vash.opt")
idx2 = (res[,3]=="gtex90.prec,df=10" & res[,4]=="limma")
idx3 = (res[,3]=="gtex90.prec,df=10" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.4,0.7),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black")
title('df=10',ylab='Precision RRMSE')
#abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="gtex90.prec,df=50" & res[,4]=="vash.opt")
idx2 = (res[,3]=="gtex90.prec,df=50" & res[,4]=="limma")
idx3 = (res[,3]=="gtex90.prec,df=50" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.8,1),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black")
title('df=50',ylab='Precision RRMSE')

idx1 = (res[,3]=="gtex90.var,df=3" & res[,4]=="vash.opt")
idx2 = (res[,3]=="gtex90.var,df=3" & res[,4]=="limma")
idx3 = (res[,3]=="gtex90.var,df=3" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0,.15),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black")
title('Brain-Cerebellar Hemisphere vs.\n Stomach,\n df=3',ylab='Precision RRMSE')
#abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="gtex90.var,df=10" & res[,4]=="vash.opt")
idx2 = (res[,3]=="gtex90.var,df=10" & res[,4]=="limma")
idx3 = (res[,3]=="gtex90.var,df=10" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.4,0.7),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black")
title('df=10',ylab='Precision RRMSE')
#abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="gtex90.var,df=50" & res[,4]=="vash.opt")
idx2 = (res[,3]=="gtex90.var,df=50" & res[,4]=="limma")
idx3 = (res[,3]=="gtex90.var,df=50" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.8,1),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black")
title('df=50',ylab='Precision RRMSE')

idx1 = (res[,3]=="gtex75.prec,df=3" & res[,4]=="vash.opt")
idx2 = (res[,3]=="gtex75.prec,df=3" & res[,4]=="limma")
idx3 = (res[,3]=="gtex75.prec,df=3" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0,.15),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black")
title('Fallopian Tube vs.\n Skin-Not Sun Exposed (Suprapubic),\n df=3',ylab='Precision RRMSE')

idx1 = (res[,3]=="gtex75.prec,df=10" & res[,4]=="vash.opt")
idx2 = (res[,3]=="gtex75.prec,df=10" & res[,4]=="limma")
idx3 = (res[,3]=="gtex75.prec,df=10" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.4,0.7),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black")
title('df=10',ylab='Precision RRMSE')

idx1 = (res[,3]=="gtex75.prec,df=50" & res[,4]=="vash.opt")
idx2 = (res[,3]=="gtex75.prec,df=50" & res[,4]=="limma")
idx3 = (res[,3]=="gtex75.prec,df=50" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.8,1),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black")
title('df=50',ylab='Precision RRMSE')

idx1 = (res[,3]=="gtex75.var,df=3" & res[,4]=="vash.opt")
idx2 = (res[,3]=="gtex75.var,df=3" & res[,4]=="limma")
idx3 = (res[,3]=="gtex75.var,df=3" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0,.15),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black")
title('Adrenal Gland\n vs. Stomach, \n df=3',ylab='Precision RRMSE')
#abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="gtex75.var,df=10" & res[,4]=="vash.opt")
idx2 = (res[,3]=="gtex75.var,df=10" & res[,4]=="limma")
idx3 = (res[,3]=="gtex75.var,df=10" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.4,0.7),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black")
title('df=10',ylab='Precision RRMSE')
#abline(h=1,lty=2,col=2)

idx1 = (res[,3]=="gtex75.var,df=50" & res[,4]=="vash.opt")
idx2 = (res[,3]=="gtex75.var,df=50" & res[,4]=="limma")
idx3 = (res[,3]=="gtex75.var,df=50" & res[,4]=="limmaR")
boxplot(test$RMSE.prec_rel[idx1], test$RMSE.prec_rel[idx2], test$RMSE.prec_rel[idx3],ylim=c(0.8,1),
        names=c("vash", "limma", "limmaR"), col="grey", colMed="black")
title('df=50',ylab='Precision RRMSE')
dev.off()

