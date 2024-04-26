\name{D.to.K}
\alias{D.to.K}
\title{
Distance to kernel
}
\description{
This function converts pairwise (subject-by-subject, n by n) distance matrix to pairwise (subject-by-subject, n by n) kernel matrix.
}
\usage{
D.to.K(D)
}
\arguments{
  \item{D}{
Pairwise (subject-by-subject, n by n) distance matrix
}
}
\value{
Pairwise (subject-by-subject, n by n) kernel matrix
}
\references{
Koh H. An ensemble learning method for joint kernel association testing and principal component analysis on multiple kernels. (In Review)
}
\author{
Hyunwook Koh <hyunwook.koh@stonybrook.edu>
}

\examples{

########################################################################################
# Example 1: Upper-respiratory-tract microbiome data (Charlson et al., 2010, PLOS One) #
########################################################################################

Ks <- lapply(throat.Ds, FUN = function(d) D.to.K(d))

####################################################################
# Example 2: Oral microbiome (Park et al., 2023, BMC Microbiology) #
####################################################################

Ks <- lapply(oral.Ds, FUN = function(d) D.to.K(d))

