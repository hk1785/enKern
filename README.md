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

URL: [[https://github.com/hk1785/enKern](https://github.com/hk1785/enKern)]

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
```
Import data
```
data(throat.otu.tab)
data(throat.meta)
data(throat.tree)
data(throat.Ds)
```
