rEnddat
=======

Package Installation
-----------------------

To install the `rEnDDaT` package you need to be using R 3.0 or greater. Then use the following command:

```R
library(devtools)
install_github("USGS-R/rEnDDaT")

```

Workflow
-----------------------

```r
library("rEnDDaT")

fileName <- "Sheridan.csv"
filePath <- system.file("extdata", package="rEnDDaT")
totalParams <- getParamsFromFile(filePath, fileName)

# General beach info - optional:
beachName <- 'Random Beach'
tzone <- '-6_CST' # Options: ('-6_CST', '0_GMT', '-5_CDT','-5_EST', etc)...basically 'hours offset_abbrievation'
lake <- 'michigan' # Required if requesting GLCFS data ('michigan','erie','huron','ontario','superior')
gap <- 6 # If there is processing done, this is the number of hours back to look for data

# Time Range required:
##############################################
# Very important:
# Only do one year at a time especially for GLCFS data!
##############################################
endPosition <- as.character(Sys.Date())
beginPosition <-  as.character(Sys.Date()-7)

# Optional:
#go to http://cida.usgs.gov/enddat/DataList.jsp, upload Times, and paste Filter file ID here
# filterID <- "c8a200ca-11ca-4d30-b9c9-3fe0dee5ca48"
# baseReturn <- generateBaseUrl(beginPosition, endPosition,
#                               beachName=beachName, tzone=tzone,
#                               lake=lake,gap=gap,filter=filterID)

baseReturn <- generateBaseUrl(beginPosition, endPosition,
                              beachName=beachName, tzone=tzone,
                              lake=lake,gap=gap)

EnDDaTData <- getEnDDaTData(totalParams, baseReturn, archive=FALSE,endPostion,beginPosition)

# Or separately:
NWISData <- getNWISData(totalParams, baseReturn)
GLCFSData <- getGLCFSData(totalParams, baseReturn)
# GDPData <- getGDPData(totalParams, baseReturn, archive=FALSE,endPostion,beginPosition)
# PrecipPointData <- getPRECIPData(totalParams, baseReturn)

```

Disclaimer
----------

This software is in the public domain because it contains materials that originally came from the United States Geological Survey, an agency of the United States Department of Interior. For more information, see the official USGS copyright policy at [http://www.usgs.gov/visual-id/credit_usgs.html#copyright](http://www.usgs.gov/visual-id/credit_usgs.html#copyright)

Although this software program has been used by the U.S. Geological Survey (USGS), no warranty, expressed or implied, is made by the USGS or the U.S. Government as to the accuracy and functioning of the program and related program material nor shall the fact of distribution constitute any such warranty, and no responsibility is assumed by the USGS in connection therewith.

This software is provided "AS IS."

 [
   ![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png)
 ](http://creativecommons.org/publicdomain/zero/1.0/)
