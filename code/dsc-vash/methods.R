# Methods: orginial t-test, limma, limma-robust, vash, vash with single component prior
sourceDir("methods")

# Original t-test
addMethod(dsc_vash,name="baseline",fn=originalt.wrapper,outputtype="est_output",args=NULL)

# limma (Smyth, 2005)
addMethod(dsc_vash,name="limma",fn=limma.wrapper,outputtype="limma_output",args=list(robust=FALSE))

# limma-robust (Philpson et al, 2014)
addMethod(dsc_vash,name="limmaR",fn=limma.wrapper,outputtype="limma_output",args=list(robust=TRUE))

# vash with single component prior
addMethod(dsc_vash,"vashS",vash.wrapper,outputtype="vash_output",
          args=list(singlecomp=TRUE))

# vash (automatically choose vash.var or vash.prec)
addMethod(dsc_vash,"vash.opt",vash.wrapper,outputtype="vash_output",
          args=list(singlecomp=FALSE, unimodal="auto"))

