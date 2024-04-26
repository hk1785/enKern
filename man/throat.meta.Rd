\name{throat.meta}
\alias{throat.meta}
\docType{data}
\title{
Metadata for the upper-respiratory-tract microbiome data (Charlson et al., 2010, PLOS One)
}
\description{
Metadata for the upper-respiratory-tract microbiome data (Charlson et al., 2010, PLOS One)
}
\usage{data("throat.meta")}
\format{
  A data frame with 57 observations on the following 16 variables.
  \describe{
    \item{\code{BarcodeSequence}}{a character vector}
    \item{\code{LinkerPrimerSequence}}{a character vector}
    \item{\code{SmokingStatus}}{a character vector}
    \item{\code{PatientID}}{a character vector}
    \item{\code{SampleIndex}}{a character vector}
    \item{\code{AirwaySite}}{a character vector}
    \item{\code{SideOfBody}}{a character vector}
    \item{\code{SampleType}}{a character vector}
    \item{\code{RespiratoryDiseaseStatus_severity_timeframe}}{a character vector}
    \item{\code{AntibioticUsePast3Months_TimeFromAntibioticUsage}}{a character vector}
    \item{\code{Age}}{a character vector}
    \item{\code{Sex}}{a character vector}
    \item{\code{PackYears}}{a character vector}
    \item{\code{TimeFromLastCig}}{a character vector}
    \item{\code{TimeFromLastMeal}}{a character vector}
    \item{\code{Description}}{a character vector}
  }
}

\references{
Charlson ES, Chen J, Custers-Allen R, Bittinger K, Li H, Sinha R, Hwang J, Bushman FD, Collman RG. Disordered microbial communities in the upper respiratory tract of cigarette smokers. PLoS One, 5(12):e15216, 2010

Koh H. An ensemble learning method for joint kernel association testing and principal component analysis on multiple kernels. (In Review)
}

\examples{
data(throat.meta)
}
\keyword{datasets}
