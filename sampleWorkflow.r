# Get Enddat workflow:

# NWIS:
siteNumber <- '04024000'
parameterCd <- '00060'
statCd <- '00003'
colName <- 'Gage height [ft]'
firstReturn <- generateNWISurl(siteNumber, parameterCd,statCd,colName)
process <- 'Mean'
numHours <- 48
processedReturn <- addStatProcess(firstReturn, process, numHours)

#GLCFS:
xPoint <- 130
yPoint <- 13
zPoint <- -1
sourceNum <- 0
varName <- 'vc'
colName <- 'Northward velocity at surface'
GLCFScall <- generateGLCFSurl(xPoint, yPoint,zPoint,sourceNum,varName,colName)
processGLCFS <- addStatProcess(GLCFScall, process, numHours)

# General:
beachName <- 'Sample Beach'
beginPosition <- '2006-10-02'
endPosition <- '2006-10-05'
tzone <- '-6_CST'
lake <- 'michigan'
beachLat <- ''
beachLon <- ''

baseReturn <- generateBaseUrl(beachName, beginPosition,endPosition,tzone,lake,beachLat,beachLon)

testURL <- paste(baseReturn,processedReturn,firstReturn,GLCFScall,processGLCFS,sep="&")

setInternet2(use=NA)
setInternet2(use=FALSE)
setInternet2(use=NA)

getData <- read.delim(  
  testURL, 
  header = TRUE, 
  dec=".", 
  sep='\t',
  fill = TRUE, 
  comment.char="#")

getData$time <- as.POSIXct(getData$time, "%m/%d/%Y %H:%M",tz="")



