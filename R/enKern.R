enKern <-
function(Y, X = NULL, Ks, out.type = c("binary", "continuous"), n.perm = 1000) {
  
  H <- length(Ks)
  
  meta.d <- as.data.frame(cbind(Y, X))
  ind.na <- apply(meta.d, 1, function(x) sum(is.na(x)))
  meta.d <- as.data.frame(model.matrix(~ ., data = meta.d)[,-1])
  Y <- as.numeric(meta.d[, 1])
  X <- meta.d[, -1]
  for (i in 1:H) {
    Ks[[i]] <- Ks[[i]][ind.na == 0, ind.na == 0]
  }
  
  n <- nrow(Ks[[1]])
  
  ran.ind <- list()
  for (i in 1:n.perm) {
    ran.ind[[i]] <- sample(1:n)
  }
  
  itembyitem.PCs <- Vs <- lapply(Ks, function(k) {
    svd.k.out <- svd(k)
    (svd.k.out$u %*% sqrt(diag(svd.k.out$d)))[,svd.k.out$d > 0]})
  
  itembyitem.eigenvals <- eivals <- lapply(Ks, function(k) {
    svd.k.out <- svd(k)
    svd.k.out$d[svd.k.out$d > 0]})
  
  if (is.null(X)) {
    R <- Y
  } else {
    if (out.type == "binary") {
      R <- Y - glm(Y ~ ., data = meta.d, family = binomial())$fitted.values
    }
    if (out.type == "continuous") {
      R <- Y - glm(Y ~ ., data = meta.d, family = gaussian())$fitted.values
    }
  }
  
  R.perm <- lapply(ran.ind, function(x) R[x])
  
  T.obs.list <- lapply(Ks, function(x) as.numeric(t(R) %*% x %*% R))
  T.null.list <- list()
  for (i in 1:H) {
    T.null.list[[i]] <-sapply(R.perm, function(x) as.numeric(t(x) %*% Ks[[i]] %*% x))
  }
  itembyitem.pvals <- numeric()
  for (i in 1:H) {
    itembyitem.pvals[i] <- (sum((abs(T.null.list[[i]]) > abs(T.obs.list[[i]]))) + 1)/(n.perm + 1)
  }
  
  ses <- sapply(T.null.list, sd)
  weight <- (1/ses)/sum(1/ses)
  
  weighted.K <- weight[1] * Ks[[1]]
  for (i in 2:H) {
    weighted.K <- weighted.K + weight[i] * Ks[[i]]
  }
  
  T.obs.weight <- T.obs.list[[1]] * weight[1]
  for (i in 2:H) {
    T.obs.weight <- T.obs.weight + T.obs.list[[i]] * weight[i]
  }
  
  T.null.weight <- T.null.list[[1]] * weight[1]
  for (i in 2:H) {
    T.null.weight <- T.null.weight + T.null.list[[i]] * weight[i]
  }
  
  enKern.pval <- (sum((abs(T.null.weight) > abs(T.obs.weight))) + 1)/(n.perm + 1)
  
  svd.k.out <- svd(weighted.K)
  enKern.PCs <- (svd.k.out$u %*% sqrt(diag(svd.k.out$d)))[,svd.k.out$d > 0]
  enKern.eigenvals <- svd.k.out$d[svd.k.out$d > 0]
  
  output <- list(itembyitem.pvals = itembyitem.pvals, enKern.pval = enKern.pval, itembyitem.PCs = itembyitem.PCs, itembyitem.eigenvals = itembyitem.eigenvals, enKern.PCs = enKern.PCs, enKern.eigenvals = enKern.eigenvals)
  
  return(output)
}
