D.to.K <-
function(D) {
  
  n <- nrow(D)
  centerM <- diag(n) - 1/n
  K <- -0.5 * centerM %*% (D * D) %*% centerM
  
  return(K)
}
