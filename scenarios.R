sourceDir("datamakers")
scenarios=list()

# 4 simulation scenarios
scenarios[[1]]=list(name="A,df=3", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=3, unimodal='variance', priortype='inversegamma',
                              pi=1, alpha=5, c=1),
                    seed=1:50)

scenarios[[2]]=list(name="A,df=10", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=10, unimodal='variance', priortype='inversegamma',
                              pi=1, alpha=5, c=1),
                    seed=1:50)
scenarios[[3]]=list(name="A,df=50", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=50, unimodal='variance', priortype='inversegamma',
                              pi=1, alpha=5, c=1),
                    seed=1:50)

scenarios[[4]]=list(name="B,df=3", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=3, unimodal='variance', priortype='inversegamma',
                              pi=c(0.1,0.9),alpha=c(4,15),c=1),
                    seed=1:50)

scenarios[[5]]=list(name="B,df=10", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=10, unimodal='variance', priortype='inversegamma',
                              pi=c(0.1,0.9),alpha=c(4,15),c=1),
                    seed=1:50)
scenarios[[6]]=list(name="B,df=50", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=50, unimodal='variance', priortype='inversegamma',
                              pi=c(0.1,0.9),alpha=c(4,15),c=1),
                    seed=1:50)

scenarios[[7]]=list(name="C,df=3", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=3, unimodal='variance', priortype='inversegamma',
                              pi=c(0.1,0.4,0.5),alpha=c(4,6,30),c=1),
                    seed=1:50)
scenarios[[8]]=list(name="C,df=10", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=10, unimodal='variance', priortype='inversegamma',
                              pi=c(0.1,0.4,0.5),alpha=c(4,6,30),c=1),
                    seed=1:50)
scenarios[[9]]=list(name="C,df=50", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=50, unimodal='variance', priortype='inversegamma',
                              pi=c(0.1,0.4,0.5),alpha=c(4,6,30),c=1),
                    seed=1:50)

scenarios[[10]]=list(name="D,df=3", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=3, unimodal='variance', priortype='lognormal',
                              pi=c(0.1,0.6,0.3),lnsd=c(0.05,0.5,1),c=1),
                    seed=1:50)

scenarios[[11]]=list(name="D,df=10", fn=datamaker,
                     args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                               df=10, unimodal='variance', priortype='lognormal',
                               pi=c(0.1,0.6,0.3),lnsd=c(0.05,0.5,1),c=1),
                     seed=1:50)

scenarios[[12]]=list(name="D,df=50", fn=datamaker,
                     args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                               df=50, unimodal='precision', priortype='lognormal',
                               pi=c(0.1,0.6,0.3),lnsd=c(0.05,0.5,1),c=1),
                     seed=1:50)

scenarios[[13]]=list(name="E,df=3", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=3, unimodal='precision', priortype='inversegamma',
                              pi=1, alpha=5, c=1),
                    seed=1:50)

scenarios[[14]]=list(name="E,df=10", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=10, unimodal='precision', priortype='inversegamma',
                              pi=1, alpha=5, c=1),
                    seed=1:50)
scenarios[[15]]=list(name="E,df=50", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=50, unimodal='precision', priortype='inversegamma',
                              pi=1, alpha=5, c=1),
                    seed=1:50)

scenarios[[16]]=list(name="F,df=3", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=3, unimodal='precision', priortype='inversegamma',
                              pi=c(0.1,0.9),alpha=c(2,10),c=1),
                    seed=1:50)

scenarios[[17]]=list(name="F,df=10", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=10, unimodal='precision', priortype='inversegamma',
                              pi=c(0.1,0.9),alpha=c(2,10),c=1),
                    seed=1:50)
scenarios[[18]]=list(name="F,df=50", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=50, unimodal='precision', priortype='inversegamma',
                              pi=c(0.1,0.9),alpha=c(2,10),c=1),
                    seed=1:50)

scenarios[[19]]=list(name="G,df=3", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=3, unimodal='precision', priortype='inversegamma',
                              pi=c(0.1,0.4,0.5),alpha=c(2,5,30),c=1),
                    seed=1:50)
scenarios[[20]]=list(name="G,df=10", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=10, unimodal='precision', priortype='inversegamma',
                              pi=c(0.1,0.4,0.5),alpha=c(2,5,30),c=1),
                    seed=1:50)
scenarios[[21]]=list(name="G,df=50", fn=datamaker,
                    args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                              df=50, unimodal='precision', priortype='inversegamma',
                              pi=c(0.1,0.4,0.5),alpha=c(2,5,30),c=1),
                    seed=1:50)

scenarios[[22]]=list(name="H,df=3", fn=datamaker,
                     args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                               df=3, unimodal='precision', priortype='lognormal',
                               pi=c(0.1,0.6,0.3),lnsd=c(0.05,0.5,1),c=1),
                     seed=1:50)

scenarios[[23]]=list(name="H,df=10", fn=datamaker,
                     args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                               df=10, unimodal='precision', priortype='lognormal',
                               pi=c(0.1,0.6,0.3),lnsd=c(0.05,0.5,1),c=1),
                     seed=1:50)

scenarios[[24]]=list(name="H,df=50", fn=datamaker,
                     args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                               df=50, unimodal='precision', priortype='lognormal',
                               pi=c(0.1,0.6,0.3),lnsd=c(0.05,0.5,1),c=1),
                     seed=1:50)