\name{generateBaseUrl}
\alias{generateBaseUrl}
\title{Generate baseURL for EnDDaT}
\usage{
  generateBaseUrl(beachName = "", beginPosition = "",
    endPosition = "", tzone = "-6_CST", lake = "michigan",
    beachLat = "", beachLon = "", filter = "", gap = "")
}
\arguments{
  \item{beachName}{string optional}

  \item{beginPosition}{string 'YYYY-MM-DD' optional}

  \item{endPosition}{string 'YYYY-MM-DD' optional}

  \item{tzone}{string hour_abbreviation required, default
  is '-6_CST'}

  \item{lake}{string required, default is 'michigan'}

  \item{beachLat}{string optional}

  \item{beachLon}{string optional}

  \item{filter}{string optional}

  \item{gap}{int optional}
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
FischerFilterID <- "0925af38-d570-402f-a6ed-1e25f0554364"
gap <- 6
baseReturn <- generateBaseUrl(beachName, beginPosition,endPosition,tzone,lake,beachLat,beachLon,FischerFilterID,gap)
}

