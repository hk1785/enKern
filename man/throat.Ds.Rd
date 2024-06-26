\name{throat.Ds}
\alias{throat.Ds}
\docType{data}
\title{
A list of ecological (pairwise, subject-by-subject, n by n) distance matrices for the upper-respiratory-tract microbiome data (Charlson et al., 2010, PLOS One)
}
\description{
A list of ecological (pairwise, subject-by-subject, n by n) distance matrices for the upper-respiratory-tract microbiome data (Charlson et al., 2010, PLOS One)
}
\usage{data("throat.Ds")}
\format{
  The format is:
List of 7
 $ Jaccard       : num [1:57, 1:57] 0 0.831 0.822 0.739 0.833 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
 $ Bray-Curtis   : num [1:57, 1:57] 0 0.866 0.839 0.884 0.863 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
 $ UUniFrac      : num [1:57, 1:57] 0 0.677 0.615 0.622 0.673 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
 $ GUniFrac(0.25): num [1:57, 1:57] 0 0.791 0.744 0.752 0.792 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
 $ GUniFrac(0.5) : num [1:57, 1:57] 0 0.65 0.606 0.622 0.652 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
 $ GUniFrac(0.75): num [1:57, 1:57] 0 0.47 0.433 0.453 0.475 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
 $ WUniFrac      : num [1:57, 1:57] 0 0.31 0.277 0.294 0.311 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
  .. ..$ : chr [1:57] "ESC_1.1_OPL" "ESC_1.3_OPL" "ESC_1.4_OPL" "ESC_1.5_OPL" ...
}

\references{
Charlson ES, Chen J, Custers-Allen R, Bittinger K, Li H, Sinha R, Hwang J, Bushman FD, Collman RG. Disordered microbial communities in the upper respiratory tract of cigarette smokers. PLoS One, 5(12):e15216, 2010

Koh H. An ensemble learning method for joint kernel association testing and principal component analysis on multiple kernels. (In Review)
}

\examples{
data(throat.Ds)
}
\keyword{datasets}
