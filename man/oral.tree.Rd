\name{oral.tree}
\alias{oral.tree}
\docType{data}
\title{
A phylogenetic tree for the oral microbiome data (Park et al., 2023, BMC Microbiology)
}
\description{
A phylogenetic tree for the oral microbiome data (Park et al., 2023, BMC Microbiology)
}
\usage{data("oral.tree")}
\format{
  The format is:
List of 5
 $ edge       : int [1:4426, 1:2] 2267 2268 2268 2267 2269 2270 2271 2272 2272 2273 ...
 $ edge.length: num [1:4426] 1.3401 0.12963 0.00874 0.1415 0.0143 ...
 $ Nnode      : int 2161
 $ node.label : chr [1:2161] "0.619" "1.000" "0.788" "0.413" ...
 $ tip.label  : chr [1:2266] "baffdd5aeb33baeb1986832b42cd85b6" "9ac18d4675f49b644622fcb407ae66fc" "eb274187d314720a2e5c03bbf259882f" "f671cb28dc12790ee555bec5ca05190d" ...
 - attr(*, "class")= chr "phylo"
 - attr(*, "order")= chr "cladewise"
}

\references{
Park B, Koh H, Patatanian M, Reyes-Caballero H, Zhao N, Meinert J, Holbrook JT, Leinbach LI, Biswal S. The mediating roles of the oral microbiome in saliva and subgingival sites between e-cigarette smoking and gingival inflammation. BMC Microbiol, 23(35), 2023

Koh H. An ensemble learning method for joint kernel association testing and principal component analysis on multiple kernels. (In Review)
}

\examples{
data(oral.tree)
}
\keyword{datasets}
