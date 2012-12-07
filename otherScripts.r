#######################################################################################
#######################################################################################
#######################################################################################
# Starting with Becky's file:

# library("XLConnect")
# NWISInfo2 <- readWorksheetFromFile("M:/QW Monitoring Team/GLRI beaches/Modeling/Model development 2012/Fischer Parameter list_LD.xlsx",
#                                   sheet=c("NWIS"),
#                                   header = TRUE,
#                                   startCol=0, endCol=9)
# GLCFSInfo2 <- readWorksheetFromFile("M:/QW Monitoring Team/GLRI beaches/Modeling/Model development 2012/Fischer Parameter list_LD.xlsx",
#                                     sheet=c("GLCFS"),
#                                     header = TRUE,
#                                     startCol=0, endCol=11)
# GLCFSInfo2$beach.orientation <- as.numeric(GLCFSInfo2$beach.orientation)


NWISInfo <- readWorksheetFromFile("M:/QW Monitoring Team/GLRI beaches/Modeling/Model development 2012/Fischer Parameter list.xlsx",
                                  sheet=c("NWIS"),
                                  header = TRUE,
                                  startCol=0, endCol=7)
NWISInfo <- NWISInfo[,c(1:5,7)]
NWISInfo <- NWISInfo[!is.na(NWISInfo$Source),]

NWISkey <- c('00065','63680','00095','00045')
names(NWISkey) <- c("Discharge","Turbidity","SpCond","ARF")
siteKey <- c('04085427')
names(siteKey) <- c('Manitowoc')
NWISInfo$siteNo <- siteKey[NWISInfo$Station.name]
NWISInfo$pCode <- NWISkey[NWISInfo$Descriptor]
NWISInfo$statCd <- '00003'


for (i in 1:nrow(NWISInfo)){
  if(1 == i){
    NWISCalls <- with(NWISInfo, generateProcessNWISurl(siteNo[i],pCode[i],Combined.name[i],Statistic[i],Hours[i],statCd[i]))    
  } else {
    NWISCalls <- append(NWISCalls,with(NWISInfo, generateProcessNWISurl(siteNo[i],pCode[i],Combined.name[i],Statistic[i],Hours[i],statCd[i])))
  }  
}

GLCFSInfo <- readWorksheetFromFile("M:/QW Monitoring Team/GLRI beaches/Modeling/Model development 2012/Fischer Parameter list.xlsx",
                                   sheet=c("GLCFS"),
                                   header = TRUE,
                                   startCol=0, endCol=5)
GLCFSInfo <- GLCFSInfo[,c(1:3,5)]

GLCFSVarkey <- c("cl",
                 "vtm",
                 "vc",
                 "wvh",
                 "wvd",
                 "air_v",
                 "at",
                 "temp",
                 "eta")
names(GLCFSVarkey) <-c("CloudCover", 
                       "CurrentDepthAveraged", #so these are parallel? perp?
                       "CurrentSurface", #so these are parallel? perp?
                       "WaveHeight", 
                       "WaveHeightDirection", # I'm guessing this is the processed Dir...
                       "Wind", #so these are parallel? perp?
                       "AirTemperature", 
                       "WaterTemperature", 
                       "HeightAboveSeaLevel")

GLCFSSourcekey <- c(1,0,0,0,0,1,1,2,0)
names(GLCFSSourcekey) <-c("CloudCover", 
                          "CurrentDepthAveraged", #so these are parallel? perp?
                          "CurrentSurface", #so these are parallel? perp?
                          "WaveHeight", 
                          "WaveHeightDirection", # I'm guessing this is the processed Dir...
                          "Wind", #so these are parallel? perp?
                          "AirTemperature", 
                          "WaterTemperature", 
                          "HeightAboveSeaLevel")

GLCFSInfo$variableName <- GLCFSVarkey[GLCFSInfo$Descriptor]
GLCFSInfo$sourceNumber <- GLCFSSourcekey[GLCFSInfo$Descriptor]

##################################################################################
# Build package
library(devtools)
setwd("D:/LADData/RCode/")
load_all("EnDDaT/",reset = TRUE)
setwd("D:/LADData/RCode/EnDDaT")
document()
check()
# run_examples()
# test()   #Assumes testthat type tests in EnDDaT/inst/tests
setwd("D:/LADData/RCode/")
build("EnDDaT")
install("EnDDaT")
