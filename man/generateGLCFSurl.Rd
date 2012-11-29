\name{generateGLCFSurl}
\alias{generateGLCFSurl}
\title{Get GLCFS parts of URL for EnDDaT}
\usage{
  generateGLCFSurl(xPoint, yPoint, zPoint, sourceNum,
    varName, colName)
}
\arguments{
  \item{siteNumber}{string USGS site ID numbers}

  \item{pCode}{string 5 digit parameter code}

  \item{statCd}{string 5 digit stat code}

  \item{colName}{string column name}
}
\value{
  GLCFScall string
}
\description{
  Get GLCFS parts of URL for EnDDaT
}
\examples{
xPoint <- 130
yPoint <- 13
zPoint <- -1
sourceNum <- 0
varName <- 'vc'
colName <- 'Northward velocity at surface'

firstReturn <- generateGLCFSurl(xPoint, yPoint,zPoint,sourceNum,varName,colName)
}

