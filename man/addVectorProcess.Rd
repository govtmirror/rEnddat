\name{addVectorProcess}
\alias{addVectorProcess}
\title{Add vector processing to call}
\usage{
  addVectorProcess(urlSection, vectorProcess, angle = 0,
    customColName = "")
}
\arguments{
  \item{urlSection}{string USGS site ID numbers}

  \item{vectorProcess}{string options are 'par' 'perp'
  'angle' 'magnitude'.  If angle or magnitude, no beach
  angle required.}

  \item{angle}{number beach angle in degrees from north.
  Default is 0}

  \item{customColName}{string Column name if not
  auto-generated}
}
\value{
  vectorCall string
}
\description{
  Add vector processing to call
}
\examples{
xPoint <- 130
yPoint <- 13
zPoint <- -1
sourceNum <- 0
varName <- 'vc'
colName <- 'Northward velocity at surface'

glcfsReturn <- generateGLCFSurl(xPoint, yPoint,zPoint,sourceNum,varName,colName)
vectorProcess <- 'par'
angle <- 22.1
vectorReturn <- addVectorProcess(glcfsReturn, vectorProcess, angle)
}

