\name{generateProcessNWISurl}
\alias{generateProcessNWISurl}
\title{Get NWIS processed parts of URL for EnDDaT}
\usage{
  generateProcessNWISurl(siteNumber, pCode, colName,
    process, numHours, statCd)
}
\arguments{
  \item{siteNumber}{string USGS site ID numbers}

  \item{pCode}{string 5 digit parameter code}

  \item{statCd}{string 5 digit stat code}

  \item{colName}{string column name}

  \item{process}{string statistical process available
  processes are Mean,Min,Max,Sum,Diff,StDev}

  \item{numHours}{integer number of hours to process}
}
\value{
  processedNWIScall string
}
\description{
  Get NWIS processed parts of URL for EnDDaT
}
\examples{
siteNumber <- '04024000'
parameterCd <- '00060'
statCd <- '00003'
colName <- 'Gage height [ft]'
process <- 'Mean'
numHours <- 6
firstReturn <- generateProcessNWISurl(siteNumber, parameterCd,statCd,colName,process,numHours)
}

