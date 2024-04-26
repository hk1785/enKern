\name{enKern}
\alias{enKern}
\title{
enKern
}
\description{
This function conducts enKern for joint kernel association testing and principal component analysis on multiple input kernels.
}
\usage{
enKern(Y, X = NULL, Ks, out.type = c("binary", "continuous"), n.perm = 1000)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Y}{
A numeric vector of binary or continuous responses.
}
  \item{X}{
A matrix for covariates (e.g., age, sex).
}
  \item{Ks}{
A list of pairwise (subject-by-subject, n by n) kernel matrices.
}
  \item{out.type}{
The type of the response variable: "binary" or "continuous".
}
  \item{n.perm}{
The number of permutations (Default: 1000). 
}
}

\value{
itembyitem.pvals: P-values for individual kernel association tests
enKern.pval: A P-value for enKern
itembyitem.PCs: Principal components for individual kernels
itembyitem.eigenvals: Eigenvalues for individual kernels
enKern.PCs: Principal components for enKern
enKern.eigenvals: Eigenvalues for enKern
}

\references{
Koh H. An ensemble learning method for joint kernel association testing and principal component analysis on multiple kernels. (In Review)
}

\author{
Hyunwook Koh <hyunwook.koh@stonybrook.edu>
}

\note{
A large number of permutations is recommended for sufficient convergency. 
}

\examples{
########################################################################################
# Example 1: Upper-respiratory-tract microbiome data (Charlson et al., 2010, PLOS One) #
########################################################################################

Ks <- lapply(throat.Ds, FUN = function(d) D.to.K(d))

###################
# Binary response #
###################

Y <- as.numeric(as.factor(throat.meta$SmokingStatus)) - 1
X <- cbind(as.numeric(throat.meta$Age), as.factor(throat.meta$Sex))

set.seed(487)

system.time(enKern.out <- enKern(Y, X = X, Ks = Ks, out.type = "binary", n.perm = 1000000)) 

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

system.time(enKern.out <- enKern(Y, X = X, Ks = Ks, out.type = "continuous", n.perm = 1000000)) 

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

####################################################################
# Example 2: Oral microbiome (Park et al., 2023, BMC Microbiology) #
####################################################################

Ks <- lapply(oral.Ds, FUN = function(d) D.to.K(d))

###################
# Binary response #
###################

Y <- oral.meta$gingival.inflammation
X <- cbind(oral.meta$age, oral.meta$brush)

set.seed(487)

system.time(enKern.out <- enKern(Y, X = X, Ks = Ks, out.type = "binary", n.perm = 1000000)) 

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

system.time(enKern.out <- enKern(Y, X = X, Ks = Ks, out.type = "continuous", n.perm = 1000000)) 

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
}
