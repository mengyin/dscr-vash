# Score: log-likelihood of variance model
score = function(data, output){
  if (class(output)=="try-error"){
    res = NA 
  }else{
    res = output$loglike
  }  
  names(res) = "loglike"
  return(res)
}
