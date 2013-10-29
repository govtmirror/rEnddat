\name{getGDPData}
\alias{getGDPData}
\title{Get GDP id for EnDDaT}
\usage{
  getGDPData(totalParams, baseReturn, archive = TRUE,
    endPosition, beginPosition)
}
\arguments{
  \item{totalParams}{dataframe}

  \item{baseReturn}{string}

  \item{archive}{logical If data is being requested in the
  several 2 weeks (currently goes back to 5 months), set to
  FALSE, otherwise set to TRUE (the default). Be aware,
  there is a gap between the real-time and archive.}

  \item{endPosition}{character date in YYYY-MM-DD}

  \item{beginPosition}{character start date in YYYY-MM-DD}
}
\value{
  GDPData dataframe
}
\description{
  Get GDP id
}
\examples{
\dontrun{getGDPData(totalParams,baseReturn,archive=FALSE)}
}

