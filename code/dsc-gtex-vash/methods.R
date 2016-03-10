# Methods: 
# First apply voom transformation on RNA-seq data and use linear model to
# estimate effect sizes and standard errors, 
# then use limma or vash (with different options) to shrink the standard errors.
sourceDir("methods")

addMethod(dsc_gtex,name="limma",fn=limma.wrapper,outputtype="loglike_output",
          args=list(transform="voom"))
addMethod(dsc_gtex,name="voom+vash.sing",fn=vash.wrapper,outputtype="vash_output",
          args=list(transform="voom",unimodal="variance",singlecomp=TRUE))
addMethod(dsc_gtex,name="voom+vash.prec",fn=vash.wrapper,outputtype="vash_output",
          args=list(transform="voom",unimodal="precision",singlecomp=FALSE))
addMethod(dsc_gtex,name="voom+vash.var",fn=vash.wrapper,outputtype="vash_output",
          args=list(transform="voom",unimodal="variance",singlecomp=FALSE))
