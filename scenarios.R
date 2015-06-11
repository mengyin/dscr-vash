sourceDir("datamakers")

# Simulation scenarios:
# Scenarios A, B, C, D: unimodal prior on variance
# A: single component inverse-gamma prior (limma's model)
# B: 2 component inverse-gamma prior, with one "majority component" and one diffuse "outlier component",
#    (the case investigated by limma-robust)
# C: multiple component inverse-gamma prior (vash's model)
# D: multiple component log-normal prior (a long tail model to test the robustness of the methods)

# Scenarios E, F, G, H: unimodal prior on precision
# E: single component inverse-gamma prior (limma's model)
# F: 2 component inverse-gamma prior, with one "majority component" and one diffuse "outlier component",
#    (the case investigated by limma-robust)
# G: multiple component inverse-gamma prior (vash's model)
# H: multiple component log-normal prior (a long tail model to test the robustness of the methods)


addScenario(dsc_vash,name="A,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='variance', priortype='inversegamma',
                      pi=1, alpha=5, c=1),
            seed=1:50)

addScenario(dsc_vash,name="A,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='variance', priortype='inversegamma',
                      pi=1, alpha=5, c=1),
            seed=1:50)
# addScenario(dsc_vash,name="A,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='variance', priortype='inversegamma',
#                       pi=1, alpha=5, c=1),
#             seed=1:50)
# 
addScenario(dsc_vash,name="B,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='variance', priortype='inversegamma',
                      pi=c(0.1,0.9),alpha=c(4,15),c=1),
            seed=1:50)

addScenario(dsc_vash,name="B,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='variance', priortype='inversegamma',
                      pi=c(0.1,0.9),alpha=c(4,15),c=1),
            seed=1:50)
# addScenario(dsc_vash,name="B,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='variance', priortype='inversegamma',
#                       pi=c(0.1,0.9),alpha=c(4,15),c=1),
#             seed=1:50)
# 
addScenario(dsc_vash,name="C,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='variance', priortype='inversegamma',
                      pi=c(0.1,0.4,0.5),alpha=c(4,6,30),c=1),
            seed=1:50)
addScenario(dsc_vash,name="C,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='variance', priortype='inversegamma',
                      pi=c(0.1,0.4,0.5),alpha=c(4,6,30),c=1),
            seed=1:50)
# addScenario(dsc_vash,name="C,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='variance', priortype='inversegamma',
#                       pi=c(0.1,0.4,0.5),alpha=c(4,6,30),c=1),
#             seed=1:50)
# 
addScenario(dsc_vash,name="D,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='variance', priortype='lognormal',
                      pi=c(0.1,0.6,0.3),lnsd=c(0.05,0.5,1),c=1),
            seed=1:50)

addScenario(dsc_vash,name="D,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='variance', priortype='lognormal',
                      pi=c(0.1,0.6,0.3),lnsd=c(0.05,0.5,1),c=1),
            seed=1:50)
# 
# addScenario(dsc_vash,name="D,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='precision', priortype='lognormal',
#                       pi=c(0.1,0.6,0.3),lnsd=c(0.05,0.5,1),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="E,df=3", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=3, unimodal='precision', priortype='inversegamma',
#                       pi=1, alpha=5, c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="E,df=10", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=10, unimodal='precision', priortype='inversegamma',
#                       pi=1, alpha=5, c=1),
#             seed=1:50)
# addScenario(dsc_vash,name="E,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='precision', priortype='inversegamma',
#                       pi=1, alpha=5, c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="F,df=3", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=3, unimodal='precision', priortype='inversegamma',
#                       pi=c(0.1,0.9),alpha=c(2,10),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="F,df=10", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=10, unimodal='precision', priortype='inversegamma',
#                       pi=c(0.1,0.9),alpha=c(2,10),c=1),
#             seed=1:50)
# addScenario(dsc_vash,name="F,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='precision', priortype='inversegamma',
#                       pi=c(0.1,0.9),alpha=c(2,10),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="G,df=3", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=3, unimodal='precision', priortype='inversegamma',
#                       pi=c(0.1,0.4,0.5),alpha=c(2,5,30),c=1),
#             seed=1:50)
# addScenario(dsc_vash,name="G,df=10", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=10, unimodal='precision', priortype='inversegamma',
#                       pi=c(0.1,0.4,0.5),alpha=c(2,5,30),c=1),
#             seed=1:50)
# addScenario(dsc_vash,name="G,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='precision', priortype='inversegamma',
#                       pi=c(0.1,0.4,0.5),alpha=c(2,5,30),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="H,df=3", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=3, unimodal='precision', priortype='lognormal',
#                       pi=c(0.1,0.6,0.3),lnsd=c(0.05,0.5,1),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="H,df=10", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=10, unimodal='precision', priortype='lognormal',
#                       pi=c(0.1,0.6,0.3),lnsd=c(0.05,0.5,1),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="H,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='precision', priortype='lognormal',
#                       pi=c(0.1,0.6,0.3),lnsd=c(0.05,0.5,1),c=1),
#             seed=1:50)