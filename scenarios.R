sourceDir("datamakers")
# 
# # Simulation scenarios:
# # Scenarios A, B, C, D: unimodal prior on variance
# # A: single component inverse-gamma prior (limma's model)
# # B: 2 component inverse-gamma prior, with one "majority component" and one diffuse "outlier component",
# #    (the case investigated by limma-robust)
# # C: multiple component inverse-gamma prior (vash's model)
# # D: multiple component log-normal prior (a long tail model to test the robustness of the methods)
# 
# # Scenarios E, F, G, H: unimodal prior on precision
# # E: single component inverse-gamma prior (limma's model)
# # F: 2 component inverse-gamma prior, with one "majority component" and one diffuse "outlier component",
# #    (the case investigated by limma-robust)
# # G: multiple component inverse-gamma prior (vash's model)
# # H: multiple component log-normal prior (a long tail model to test the robustness of the methods)
# 
# 
# addScenario(dsc_vash,name="A,df=3", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=3, unimodal='variance', priortype='inversegamma',
#                       pi=1, alpha=5, c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="A,df=10", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=10, unimodal='variance', priortype='inversegamma',
#                       pi=1, alpha=5, c=1),
#             seed=1:50)
# addScenario(dsc_vash,name="A,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='variance', priortype='inversegamma',
#                       pi=1, alpha=5, c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="B,df=3", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=3, unimodal='variance', priortype='inversegamma',
#                       pi=c(0.1,0.9),alpha=c(4,15),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="B,df=10", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=10, unimodal='variance', priortype='inversegamma',
#                       pi=c(0.1,0.9),alpha=c(4,15),c=1),
#             seed=1:50)
# addScenario(dsc_vash,name="B,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='variance', priortype='inversegamma',
#                       pi=c(0.1,0.9),alpha=c(4,15),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="C,df=3", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=3, unimodal='variance', priortype='inversegamma',
#                       pi=c(0.1,0.4,0.5),alpha=c(4,6,30),c=1),
#             seed=1:50)
# addScenario(dsc_vash,name="C,df=10", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=10, unimodal='variance', priortype='inversegamma',
#                       pi=c(0.1,0.4,0.5),alpha=c(4,6,30),c=1),
#             seed=1:50)
# addScenario(dsc_vash,name="C,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='variance', priortype='inversegamma',
#                       pi=c(0.1,0.4,0.5),alpha=c(4,6,30),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="D,df=3", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=3, unimodal='variance', priortype='lognormal',
#                       pi=c(0.1,0.7,0.2),lnsd=c(0.05,0.2,0.5),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="D,df=10", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=10, unimodal='variance', priortype='lognormal',
#                       pi=c(0.1,0.7,0.2),lnsd=c(0.05,0.2,0.5),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="D,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='variance', priortype='lognormal',
#                       pi=c(0.1,0.7,0.2),lnsd=c(0.05,0.2,0.5),c=1),
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
#                       pi=c(0.2,0.6,0.2),lnsd=c(0.05,0.2,0.6),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="H,df=10", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=10, unimodal='precision', priortype='lognormal',
#                       pi=c(0.2,0.6,0.2),lnsd=c(0.05,0.2,0.6),c=1),
#             seed=1:50)
# 
# addScenario(dsc_vash,name="H,df=50", fn=datamaker,
#             args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
#                       df=50, unimodal='precision', priortype='lognormal',
#                       pi=c(0.2,0.6,0.2),lnsd=c(0.05,0.2,0.6),c=1),
#             seed=1:50)

# Based on gtex data (see dscr-gtex-vash)
addScenario(dsc_vash,name="gtex.var,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='variance', priortype='inversegamma',
                      pi=c(.2,.6,.2),alpha=c(1.7,2.2,7.5),c=1),
            seed=1:50)

addScenario(dsc_vash,name="gtex.var,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='variance', priortype='inversegamma',
                      pi=c(.2,.6,.2),alpha=c(1.7,2.2,7.5),c=1),
            seed=1:50)

addScenario(dsc_vash,name="gtex.var,df=50", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=50, unimodal='variance', priortype='inversegamma',
                      pi=c(.2,.6,.2),alpha=c(1.7,2.2,7.5),c=1),
            seed=1:50)

addScenario(dsc_vash,name="gtex.prec,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='precision', priortype='inversegamma',
                      pi=c(.6,.1,.3),alpha=c(1.2,2,3),c=1),
            seed=1:50)

addScenario(dsc_vash,name="gtex.prec,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='precision', priortype='inversegamma',
                      pi=c(.6,.1,.3),alpha=c(1.2,2,3),c=1),
            seed=1:50)

addScenario(dsc_vash,name="gtex.prec,df=50", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=50, unimodal='precision', priortype='inversegamma',
                      pi=c(.6,.1,.3),alpha=c(1.2,2,3),c=1),
            seed=1:50)

addScenario(dsc_vash,name="mouse.var,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='variance', priortype='inversegamma',
                      pi=c(.1,.2,.7),alpha=c(1.4,4,6.5),c=1),
            seed=1:50)

addScenario(dsc_vash,name="mouse.var,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='variance', priortype='inversegamma',
                      pi=c(.1,.2,.7),alpha=c(1.4,4,6.5),c=1),
            seed=1:50)

addScenario(dsc_vash,name="mouse.var,df=50", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=50, unimodal='variance', priortype='inversegamma',
                      pi=c(.1,.2,.7),alpha=c(1.4,4,6.5),c=1),
            seed=1:50)


# Template: Breast-MammaryTissue,Pituitary (diff of log-likelihood = 16, median)
addScenario(dsc_vash,name="gtex50.var,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='variance', priortype='inversegamma',
                      pi=c(.13,.83,.04),alpha=c(1.3,1.6,25),c=1),
            seed=1:50)

addScenario(dsc_vash,name="gtex50.var,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='variance', priortype='inversegamma',
                      pi=c(.13,.83,.04),alpha=c(1.3,1.6,25),c=1),
            seed=1:50)

addScenario(dsc_vash,name="gtex50.var,df=50", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=50, unimodal='variance', priortype='inversegamma',
                      pi=c(.13,.83,.04),alpha=c(1.3,1.6,25),c=1),
            seed=1:50)

# Template: Brain-Spinalcord(cervicalc-1),Cells-EBV-transformedlymphocytes (diff of log-likelihood = 16, median)
addScenario(dsc_vash,name="gtex50.prec,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='precision', priortype='inversegamma',
                      pi=c(.08,.89,.015,.015),alpha=c(1.35,1.65,15,26),c=1),
            seed=1:50)
addScenario(dsc_vash,name="gtex50.prec,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='precision', priortype='inversegamma',
                      pi=c(.08,.89,.015,.015),alpha=c(1.35,1.65,15,26),c=1),
            seed=1:50)
addScenario(dsc_vash,name="gtex50.prec,df=50", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=50, unimodal='precision', priortype='inversegamma',
                      pi=c(.08,.89,.015,.015),alpha=c(1.35,1.65,15,26),c=1),
            seed=1:50)

# Template: AdrenalGland,Stomach (diff of log-likelihood = 44, 75%)
addScenario(dsc_vash,name="gtex75.var,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='variance', priortype='inversegamma',
                      pi=c(.22,.73,.05),alpha=c(1.2,1.4,18.5),c=1),
            seed=1:50)
addScenario(dsc_vash,name="gtex75.var,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='variance', priortype='inversegamma',
                      pi=c(.22,.73,.05),alpha=c(1.2,1.4,18.5),c=1),
            seed=1:50)
addScenario(dsc_vash,name="gtex75.var,df=50", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=50, unimodal='variance', priortype='inversegamma',
                      pi=c(.22,.73,.05),alpha=c(1.2,1.4,18.5),c=1),
            seed=1:50)

# Template: FallopianTube,Skin-NotSunExposed(Suprapubic) (diff of log-likelihood = 44, 75%)
addScenario(dsc_vash,name="gtex75.prec,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='precision', priortype='inversegamma',
                      pi=c(.1,.82,.04,.04),alpha=c(1.2,1.35,3.5,5.5),c=1),
            seed=1:50)
addScenario(dsc_vash,name="gtex75.prec,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='precision', priortype='inversegamma',
                      pi=c(.1,.82,.04,.04),alpha=c(1.2,1.35,3.5,5.5),c=1),
            seed=1:50)
addScenario(dsc_vash,name="gtex75.prec,df=50", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=50, unimodal='precision', priortype='inversegamma',
                      pi=c(.1,.82,.04,.04),alpha=c(1.2,1.35,3.5,5.5),c=1),
            seed=1:50)



# Template: Brain-CerebellarHemisphere,Stomach (diff of log-likelihood = 78, 90%)
addScenario(dsc_vash,name="gtex90.var,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='variance', priortype='inversegamma',
                      pi=c(.17,.72,.06,.05),alpha=c(1.25,1.5,7.5,13),c=1),
            seed=1:50)
addScenario(dsc_vash,name="gtex90.var,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='variance', priortype='inversegamma',
                      pi=c(.17,.72,.06,.05),alpha=c(1.25,1.5,7.5,13),c=1),
            seed=1:50)
addScenario(dsc_vash,name="gtex90.var,df=50", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=50, unimodal='variance', priortype='inversegamma',
                      pi=c(.17,.72,.06,.05),alpha=c(1.25,1.5,7.5,13),c=1),
            seed=1:50)


# Template: Brain-Anteriorcingulatecortex(BA24),Cervix-Endocervix (diff of log-likelihood = 78, 90%)
addScenario(dsc_vash,name="gtex90.prec,df=3", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=3, unimodal='precision', priortype='inversegamma',
                      pi=c(.215,.685,.03,.07),alpha=c(1.2,1.4,3.6,6),c=1),
            seed=1:50)
addScenario(dsc_vash,name="gtex90.prec,df=10", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=10, unimodal='precision', priortype='inversegamma',
                      pi=c(.215,.685,.03,.07),alpha=c(1.2,1.4,3.6,6),c=1),
            seed=1:50)
addScenario(dsc_vash,name="gtex90.prec,df=50", fn=datamaker,
            args=list(N=10000, Nnull=9000, altmean=0, altsd=2,
                      df=50, unimodal='precision', priortype='inversegamma',
                      pi=c(.215,.685,.03,.07),alpha=c(1.2,1.4,3.6,6),c=1),
            seed=1:50)