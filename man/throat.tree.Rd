\name{throat.tree}
\alias{throat.tree}
\docType{data}
\title{
A phylogenetic tree for the upper-respiratory-tract microbiome data (Charlson et al., 2010, PLOS One)
}
\description{
A phylogenetic tree for the upper-respiratory-tract microbiome data (Charlson et al., 2010, PLOS One)
}
\usage{data("throat.tree")}
\format{
  The format is:
List of 4
 $ edge       : int [1:1478, 1:2] 741 742 743 744 745 746 747 748 749 750 ...
 $ Nnode      : int 739
 $ tip.label  : chr [1:740] "1883" "3114" "1483" "2576" ...
 $ edge.length: num [1:1478] 0.0945 0.0101 0.0121 0.035 0.0285 ...
 - attr(*, "class")= chr "phylo"
 - attr(*, "order")= chr "cladewise"
}

\references{
Charlson ES, Chen J, Custers-Allen R, Bittinger K, Li H, Sinha R, Hwang J, Bushman FD, Collman RG. Disordered microbial communities in the upper respiratory tract of cigarette smokers. PLoS One, 5(12):e15216, 2010

Koh H. An ensemble learning method for joint kernel association testing and principal component analysis on multiple kernels. (In Review)
}

\examples{
data(throat.tree)
}
\keyword{datasets}
