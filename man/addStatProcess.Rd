\name{addStatProcess}
\alias{addStatProcess}
\title{Add statistical processing to call}
\usage{
  addStatProcess(urlSection, process, numHours)
}
\arguments{
  \item{urlSection}{string USGS site ID numbers}

  \item{process}{string options are
  Mean,Min,Max,Sum,Diff,StDev}

  \item{numHours}{integer number of hours to process}
}
\value{
  processCall string
}
\description{
  Add statistical processing to call
}
\examples{
siteNumber <- '04024000'
parameterCd <- '00060'
statCd <- '00003'
colName <- 'Gage height [ft]'

firstCall <- generateNWISurl(siteNumber, parameterCd,statCd,colName)
process <- 'Mean'
numHours <- 6
firstReturn <- addStatProcess(firstCall, process, numHours)
}

