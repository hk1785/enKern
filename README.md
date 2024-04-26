# enKern

Title: enKern for joint KAT and PCA on multiple kernels

Version: 1.0

Date: 2024-04-26

Author: Hyunwook Koh

Maintainer: Hyunwook Koh <hyunwook.koh@stonybrook.edu>

Description: This R package provides facilities for enKern to conduct kernel association testing and principal component analysis jointly on multiple input kernels.

NeedsCompilation: no

Depends: R(>= 4.1.3), ecodist, GUniFrac, proxy, rgl

License: GPL-2

NeedsCompilation: no

## Reference

* Koh H. An ensemble learning method for joint kernel association testing and principal component analysis on multiple kernels. (_In Review_)

## Troubleshooting Tips

If you have any problems for using this R package, please report in Issues (https://github.com/hk1785/enKern/issues) or email Hyunwook Koh (hyunwook.koh@stonybrook.edu).

## Prerequites

ecodist, GUniFrac, proxy, rgl
```
install.packages(c("ecodist", "GUniFrac", "proxy", "rgl"))
```

## Installation

```
library(devtools)
install_github("hk1785/enKern", force=T)
```

---------------------------------------------------------------------------------------------------------------------------------------

## :mag: enKern

### Description
This function conducts enKern for joint kernel association testing and principal component analysis on multiple input kernels.

### Usage
```
enKern(Y, X = NULL, Ks, out.type = c("binary", "continuous"), n.perm = 1000)
```

### Arguments
* _Y_ - A numeric vector of binary or continuous responses.
* _X_ - A matrix for covariates (e.g., age, sex).
* _Ks_ - A list of pairwise (subject-by-subject, n by n) kernel matrices.
* _out.type_ - The type of the response variable: "binary" or "continuous".
* _n.perm_ - The number of permutations (Default: 1000). 

### Values
* _itembyitem.pvals_ - P-values for individual kernel association tests
* _enKern.pval_ - A P-value for enKern
* _itembyitem.PCs_ - Principal components for individual kernels
* _itembyitem.eigenvals_ - Eigenvalues for individual kernels
* _enKern.PCs_ - Principal components for enKern
* _enKern.eigenvals_ - Eigenvalues for enKern

### Example
Import requisite R packages
```
library('ecodist')
library('GUniFrac')
library('proxy')
library('rgl')
library('enKern')
```
Example 1: Upper-respiratory-tract microbiome data (Charlson et al., 2010, PLOS One)
```
data(throat.otu.tab)
data(throat.meta)
data(throat.tree)
data(throat.Ds)
```
Convert pairwise (subject-by-subject, n by n) distance matrix to pairwise (subject-by-subject, n by n) kernel matrix.
```
Ks <- lapply(throat.Ds, FUN = function(d) D.to.K(d))
```
Perform enKern.
```
###################
# Binary response #
###################

Y <- as.numeric(as.factor(throat.meta$SmokingStatus)) - 1
X <- cbind(as.numeric(throat.meta$Age), as.factor(throat.meta$Sex))

set.seed(487)

system.time(enKern.out <- enKern(Y, X = X, Ks = Ks, out.type = "binary", n.perm = 1000)) 

enKern.out$enKern.pval
head(enKern.out$enKern.PCs[,1:3])
enKern.out$enKern.eigenvals[1:3]

# 2D plot

pv <- round(enKern.out$enKern.pval, 3)
if (pv == 0) {
  pv <- "<.001"
}
if (pv == 1) {
  pv <- ">.999"
}

n <- length(Y)

cols <- rep("blue", n)
cols[which(Y == 1)] <- "red"

plot(enKern.out$enKern.PCs[,1], enKern.out$enKern.PCs[,2], 
     xlab = paste("PC 1 (", round((enKern.out$enKern.eigenvals[1]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""), 
     ylab = paste("PC 2 (", round((enKern.out$enKern.eigenvals[2]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""), sub = paste("P: ", pv, sep = ""),
     col = cols, mgp = c(2.5, 1, 0), pch = 19,
     cex = 1, cex.main = 1, cex.sub = 0.9, cex.lab = 1)
grid(20, 20, lwd = 0.8)
legend("bottomright", legend = c("Nonsmoker", "Smoker"), fill = c("blue", "red"), horiz = FALSE, bty = "n")

# 3D plot

pv <- round(enKern.out$enKern.pval, 3)
if (pv == 0) {
  pv <- "<.001"
}
if (pv == 1) {
  pv <- ">.999"
}

n <- length(Y)

cols <- rep("blue", n)
cols[which(Y == 1)] <- "red"

plot3d( 
  x = enKern.out$enKern.PCs[,2], y = enKern.out$enKern.PCs[,3], z = enKern.out$enKern.PCs[,1], 
  col = cols, 
  type = "s", 
  zlab = paste("PC 1 (", round((enKern.out$enKern.eigenvals[1]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""),
  xlab = paste("PC 2 (", round((enKern.out$enKern.eigenvals[2]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""),
  ylab = paste("PC 3 (", round((enKern.out$enKern.eigenvals[3]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""),
  main = paste("P: ", pv, sep = ""), cex.axis = 0.5)

rglwidget()

#######################
# Continuous response #
#######################

Y <- as.numeric(throat.meta$PackYears)
X <- cbind(as.numeric(throat.meta$Age), as.factor(throat.meta$Sex))

set.seed(487)

system.time(enKern.out <- enKern(Y, X = X, Ks = Ks, out.type = "continuous", n.perm = 1000)) 

enKern.out$enKern.pval
head(enKern.out$enKern.PCs[,1:3])
enKern.out$enKern.eigenvals[1:3]

# 2D plot

pv <- round(enKern.out$enKern.pval, 3)
if (pv == 0) {
  pv <- "<.001"
}
if (pv == 1) {
  pv <- ">.999"
}

n <- length(Y)
Y.cat <- as.character(cut(Y, unique(quantile(Y, seq(0, 1, 0.1))), include.lowest = FALSE))
Y.cat[which(Y == min(Y))] <- min(Y)
Y.cat <- as.factor(Y.cat)
levels(Y.cat) <- c(levels(Y.cat)[nlevels(Y.cat)], levels(Y.cat)[-nlevels(Y.cat)])

colfunc <- colorRampPalette(c("red", "blue"))
legend.image <- as.character(as.raster(matrix(colfunc(nlevels(Y.cat)))))

cols <- rep("blue", n)
for (i in 1:length(legend.image)) {
  ind <- which(as.numeric(Y.cat) == i)
  cols[ind] <- legend.image[i]
}

colfunc <- colorRampPalette(c("red", "blue"))
legend.image <- as.character(as.raster(matrix(colfunc(nlevels(Y.cat)))))

layout.matrix <- matrix(c(1, 2), nrow = 1, ncol = 2)

graphics::layout(mat = layout.matrix, widths = c(3, 1)) 

plot(enKern.out$enKern.PCs[,1], enKern.out$enKern.PCs[,2], 
     xlab = paste("PC 1 (", round((enKern.out$enKern.eigenvals[1]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""), 
     ylab = paste("PC 2 (", round((enKern.out$enKern.eigenvals[2]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""), 
     sub = paste("P: ", pv, sep = ""),
     col = cols, mgp = c(2.5, 1, 0), pch = 19, lwd = 2,
     cex = 1, cex.main = 1, cex.sub = 0.9, cex.lab = 1)
grid(20, 20, lwd = 0.8)

plot(c(0, 5), c(0, 1), type = 'n', axes = F, xlab = '', ylab = '', main = "Packs/year", cex.main = 1)
text(x = 3, y = seq(0, 1, l = length(unique(quantile(Y, seq(0, 1, 0.1))))), 
     labels = round(unique(quantile(Y, seq(0, 1, 0.1))), 0))
rasterImage(legend.image, 0, 0, 1, 1)

# 3D plot

pv <- round(enKern.out$enKern.pval, 3)
if (pv == 0) {
  pv <- "<.001"
}
if (pv == 1) {
  pv <- ">.999"
}

n <- length(Y)
Y.cat <- as.character(cut(Y, unique(quantile(Y, seq(0, 1, 0.1))), include.lowest = FALSE))
Y.cat[which(Y == min(Y))] <- min(Y)
Y.cat <- as.factor(Y.cat)
levels(Y.cat) <- c(levels(Y.cat)[nlevels(Y.cat)], levels(Y.cat)[-nlevels(Y.cat)])

colfunc <- colorRampPalette(c("red", "blue"))
legend.image <- as.character(as.raster(matrix(colfunc(nlevels(Y.cat)))))

cols <- rep("blue", n)
for (i in 1:length(legend.image)) {
  ind <- which(as.numeric(Y.cat) == i)
  cols[ind] <- legend.image[i]
}

plot3d( 
  x = enKern.out$enKern.PCs[,2], y = enKern.out$enKern.PCs[,3], z = enKern.out$enKern.PCs[,1], 
  col = cols, 
  type = "s", 
  zlab = paste("PC 1 (", round((enKern.out$enKern.eigenvals[1]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""),
  xlab = paste("PC 2 (", round((enKern.out$enKern.eigenvals[2]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""),
  ylab = paste("PC 3 (", round((enKern.out$enKern.eigenvals[3]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""),
  main = paste("P: ", pv, sep = ""), cex.axis = 0.5)

rglwidget()
```
```
Example 2: Oral microbiome (Park et al., 2023, BMC Microbiology)
```
data(oral.otu.tab)
data(oral.meta)
data(oral.tree)
data(oral.Ds)
```
Convert pairwise (subject-by-subject, n by n) distance matrix to pairwise (subject-by-subject, n by n) kernel matrix.
```
Ks <- lapply(oral.Ds, FUN = function(d) D.to.K(d))
```
Perform enKern.
```
###################
# Binary response #
###################

Y <- oral.meta$gingival.inflammation
X <- cbind(oral.meta$age, oral.meta$brush)

set.seed(487)

system.time(enKern.out <- enKern(Y, X = X, Ks = Ks, out.type = "binary", n.perm = 1000)) 

enKern.out$enKern.pval
head(enKern.out$enKern.PCs[,1:3])
enKern.out$enKern.eigenvals[1:3]

# 2D plot

pv <- round(enKern.out$enKern.pval, 3)
if (pv == 0) {
  pv <- "<.001"
}
if (pv == 1) {
  pv <- ">.999"
}

n <- length(Y)

cols <- rep("blue", n)
cols[which(Y == 1)] <- "red"

plot(enKern.out$enKern.PCs[,1], enKern.out$enKern.PCs[,2], 
     xlab = paste("PC 1 (", round((enKern.out$enKern.eigenvals[1]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""), 
     ylab = paste("PC 2 (", round((enKern.out$enKern.eigenvals[2]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""), sub = paste("P: ", pv, sep = ""),
     col = cols, mgp = c(2.5, 1, 0), pch = 19,
     cex = 1, cex.main = 1, cex.sub = 0.9, cex.lab = 1)
grid(20, 20, lwd = 0.8)
legend("bottomright", legend = c("Healthy", "Inflammation"), fill = c("blue", "red"), horiz = FALSE, bty = "n")

# 3D plot

pv <- round(enKern.out$enKern.pval, 3)
if (pv == 0) {
  pv <- "<.001"
}
if (pv == 1) {
  pv <- ">.999"
}

n <- length(Y)

cols <- rep("blue", n)
cols[which(Y == 1)] <- "red"

plot3d( 
  x = enKern.out$enKern.PCs[,2], y = enKern.out$enKern.PCs[,3], z = enKern.out$enKern.PCs[,1], 
  col = cols, 
  type = "s", 
  zlab = paste("PC 1 (", round((enKern.out$enKern.eigenvals[1]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""),
  xlab = paste("PC 2 (", round((enKern.out$enKern.eigenvals[2]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""),
  ylab = paste("PC 3 (", round((enKern.out$enKern.eigenvals[3]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""),
  main = paste("P: ", pv, sep = ""), cex.axis = 0.5)

rglwidget()

#######################
# Continuous response #
#######################

Y <- oral.meta$IL8
X <- cbind(oral.meta$age, oral.meta$brush)

set.seed(487)

system.time(enKern.out <- enKern(Y, X = X, Ks = Ks, out.type = "continuous", n.perm = 1000)) 

enKern.out$enKern.pval
head(enKern.out$enKern.PCs[,1:3])
enKern.out$enKern.eigenvals[1:3]

# 2D plot

Y <- Y[!is.na(Y)]

pv <- round(enKern.out$enKern.pval, 3)
if (pv == 0) {
  pv <- "<.001"
}
if (pv == 1) {
  pv <- ">.999"
}

n <- length(Y)
Y.cat <- as.character(cut(Y, unique(quantile(Y, seq(0, 1, 0.1))), include.lowest = FALSE))
Y.cat[which(Y == min(Y))] <- min(Y)
Y.cat <- as.factor(Y.cat)
levels(Y.cat) <- c(levels(Y.cat)[nlevels(Y.cat)], levels(Y.cat)[-nlevels(Y.cat)])

colfunc <- colorRampPalette(c("red", "blue"))
legend.image <- as.character(as.raster(matrix(colfunc(nlevels(Y.cat)))))

cols <- rep("blue", n)
for (i in 1:length(legend.image)) {
  ind <- which(as.numeric(Y.cat) == i)
  cols[ind] <- legend.image[i]
}

colfunc <- colorRampPalette(c("red", "blue"))
legend.image <- as.character(as.raster(matrix(colfunc(nlevels(Y.cat)))))

layout.matrix <- matrix(c(1, 2), nrow = 1, ncol = 2)

graphics::layout(mat = layout.matrix, widths = c(3, 1)) 

plot(enKern.out$enKern.PCs[,1], enKern.out$enKern.PCs[,2], 
     xlab = paste("PC 1 (", round((enKern.out$enKern.eigenvals[1]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""), 
     ylab = paste("PC 2 (", round((enKern.out$enKern.eigenvals[2]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""), 
     sub = paste("P: ", pv, sep = ""),
     col = cols, mgp = c(2.5, 1, 0), pch = 19, lwd = 2,
     cex = 1, cex.main = 1, cex.sub = 0.9, cex.lab = 1)
grid(20, 20, lwd = 0.8)

plot(c(0, 5), c(0, 1), type = 'n', axes = F, xlab = '', ylab = '', main = "IL8", cex.main = 1)
text(x = 3, y = seq(0, 1, l = length(unique(quantile(Y, seq(0, 1, 0.1))))), 
     labels = round(unique(quantile(Y, seq(0, 1, 0.1))), 0))
rasterImage(legend.image, 0, 0, 1, 1)

# 3D plot

Y <- Y[!is.na(Y)]

pv <- round(enKern.out$enKern.pval, 3)
if (pv == 0) {
  pv <- "<.001"
}
if (pv == 1) {
  pv <- ">.999"
}

n <- length(Y)
Y.cat <- as.character(cut(Y, unique(quantile(Y, seq(0, 1, 0.1))), include.lowest = FALSE))
Y.cat[which(Y == min(Y))] <- min(Y)
Y.cat <- as.factor(Y.cat)
levels(Y.cat) <- c(levels(Y.cat)[nlevels(Y.cat)], levels(Y.cat)[-nlevels(Y.cat)])

colfunc <- colorRampPalette(c("red", "blue"))
legend.image <- as.character(as.raster(matrix(colfunc(nlevels(Y.cat)))))

cols <- rep("blue", n)
for (i in 1:length(legend.image)) {
  ind <- which(as.numeric(Y.cat) == i)
  cols[ind] <- legend.image[i]
}

plot3d( 
  x = enKern.out$enKern.PCs[,2], y = enKern.out$enKern.PCs[,3], z = enKern.out$enKern.PCs[,1], 
  col = cols, 
  type = "s", 
  zlab = paste("PC 1 (", round((enKern.out$enKern.eigenvals[1]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""),
  xlab = paste("PC 2 (", round((enKern.out$enKern.eigenvals[2]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""),
  ylab = paste("PC 3 (", round((enKern.out$enKern.eigenvals[3]/sum(enKern.out$enKern.eigenvals)) * 100, 1), "%)", sep = ""),
  main = paste("P: ", pv, sep = ""), cex.axis = 0.5)

rglwidget()
```
