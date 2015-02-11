sourceDir("methods")
methods=list() 

# Compare methods: 
methods[[1]] = list(name="baseline",fn=originalt.wrapper,args=NULL)
methods[[2]] = list(name="limma",fn=limma.wrapper,args=list(robust=FALSE))
methods[[3]] = list(name="limmaR",fn=limma.wrapper,args=list(robust=TRUE))
methods[[4]] = list(name="vash",fn=vash.wrapper,args=list(singlecomp=FALSE))
methods[[5]] = list(name="vashS",fn=vash.wrapper,args=list(singlecomp=TRUE))

