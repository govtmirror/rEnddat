\name{generateProcessedGLCFSurl}
\alias{generateProcessedGLCFSurl}
\title{Get GLCFS processed parts of URL for EnDDaT}
\usage{
  generateProcessedGLCFSurl(xPoint, yPoint, zPoint,
    sourceNum, varName, colName, process, numHours,
    angle = NA, vector = NA)
}
\arguments{
  \item{xPoint}{string GLCFS x index}

  \item{yPoint}{string GLCFS y index}

  \item{zPoint}{string GLCFS z index}

  \item{colName}{string column name}

  \item{sourceNum}{integer defines which data source.
  Possibilities: (0,1,2)}

  \item{varName}{string variable name}

  \item{numHours}{integer number of hours}

  \item{vector}{string defines vector process.
  Possibilities: 'perp' or 'par'}

  \item{angle}{number angle from north}

  \item{process}{process string statistical process
  available processes are Mean,Min,Max,Sum,Diff,StDev}
}
\value{
  processedGLCFScall string
}
\description{
  Get GLCFS processed parts of URL for EnDDaT
}
\examples{
xPoint <- 130
yPoint <- 13
zPoint <- -1
sourceNum <- 0
varName <- 'vc'
colName <- 'Northward velocity at surface'
numHours <- 12
process <- 'Mean'
angle <- 26.2
vector <- 'perp'

firstReturn <- generateProcessedGLCFSurl(xPoint, yPoint,zPoint,sourceNum,varName,colName,process, numHours,angle,vector)
}

