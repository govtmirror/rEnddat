library("EnDDaT")

fileName <- "fischerParams.csv"
filePath <- "//igsarmewfsapa/projects/QW Monitoring Team/GLRI beaches/Modeling/Model development 2012"
totalParams <- getParamsFromFile(filePath, fileName)

#General beach info:
tzone <- '-6_CST'
lake <- 'michigan'
gap <- 6
# It might be OK to grab entire record for NWIS...but definitely not GLCFS data:
fischer2010ID <- "41ba55cf-600e-4cf7-9488-c299fb0f618b"
fischer2011ID <- "f02e6815-9784-4af1-b4da-19a148588838"
fischer2012ID <- "ad37e396-b2ff-4f80-aacb-c4455ee0be2a"

#Optional:
beachName <- 'Fischer Beach'
#other options:
# beginPosition <- '2006-10-02'
# endPosition <- '2006-10-05'
# beachLat <- ''
# beachLon <- ''

# *Should* increase loading time
setInternet2(use=NA)
setInternet2(use=FALSE)
setInternet2(use=NA)
options(timeout=120)

#2012
baseReturn <- generateBaseUrl(beachName = beachName, tzone=tzone,lake=lake,filter = fischer2012ID,gap=gap)
#Quick test:
subDF <- totalParams[77:81,]
NWISDataMini <- getNWISData(subDF,baseReturn)
GLCFSDataMini <- getGLCFSData(subDF,baseReturn)
EnDDaTDataMini <- mergeENDDAT(NWISDataMini, GLCFSDataMini)

#Slow!:
NWISData <- getNWISData(totalParams,baseReturn)
GLCFSData <- getGLCFSData(totalParams,baseReturn)
EnDDaTData <- mergeENDDAT(NWISData, GLCFSData)

#2011
baseReturn2011 <- generateBaseUrl(beachName = beachName, tzone=tzone,lake=lake,filter = fischer2011ID,gap=gap)
#Slow!:
NWISData2011 <- getNWISData(totalParams,baseReturn2011)
GLCFSData2011 <- getGLCFSData(totalParams,baseReturn2011)
EnDDaTData2011 <- mergeENDDAT(NWISData2011, GLCFSData2011)
EnDDaTData <- mergeENDDAT(EnDDaTData, EnDDaTData2011)

#2010
baseReturn2010 <- generateBaseUrl(beachName = beachName, tzone=tzone,lake=lake,filter = fischer2010ID,gap=gap)
#Slow!:
NWISData2010 <- getNWISData(totalParams,baseReturn2010)
GLCFSData2010 <- getGLCFSData(totalParams,baseReturn2010)
EnDDaTData2010 <- mergeENDDAT(NWISData2010, GLCFSData2010)
EnDDaTData <- mergeENDDAT(EnDDaTData, EnDDaTData2010)

write.csv(EnDDaTData,file="//igsarmewfsapa/projects/QW Monitoring Team/GLRI beaches/Modeling/Model development 2012/fischer.csv",row.names=FALSE)

