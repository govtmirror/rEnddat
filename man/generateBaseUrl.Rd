\name{generateBaseUrl}
\alias{generateBaseUrl}
\title{Generate baseURL for EnDDaT}
\usage{
  generateBaseUrl(beachName, beginPosition, endPosition,
    tzone, lake, beachLat, beachLon)
}
\arguments{
  \item{beachName}{string}

  \item{beginPosition}{string 'YYYY-MM-DD'}

  \item{endPosition}{string 'YYYY-MM-DD'}

  \item{tzone}{string hour_abbreviation}

  \item{lake}{string}

  \item{beachLat}{string}

  \item{beachLon}{string}

  \item{fill}{string}
}
\value{
  baseURL string
}
\description{
  Generate baseURL for EnDDaT
}
\examples{
beachName <- 'Sample Beach'
beginPosition <- '2006-10-02'
endPosition <- '2006-10-05'
tzone <- '-5_CDT'
lake <- 'michigan'
beachLat <- ''
beachLon <- ''

baseReturn <- generateBaseUrl(beachName, beginPosition,endPosition,tzone,lake,beachLat,beachLon)
}

