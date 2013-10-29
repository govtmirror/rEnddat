#' Open csv requestData file
#'
#' Open csv requestData file
#'
#' @param totalParams dataframe
#' @return requestData list
#' @export
#' @examples
#' fileName <- "ULPParams3.csv"
#' filePath <- "//igsarmewfsapa/projects/QW Monitoring Team/GLRI beaches/Modeling/Model development 2012/ULP"
#' totalParams <- getParamsFromFile(filePath,fileName)
#' requestData <- dataRequest(totalParams)
dataRequest <- function(totalParams){
  
  NWIS <- totalParams['NWIS' == totalParams$Source,]
  GLCFS <- totalParams['GLCFS' == totalParams$Source,]
  GDP <- totalParams['GDP' == totalParams$Source,]
  PRECIP <- totalParams['PRECIP' == totalParams$Source,]  
  
  padVariable <- function(x,padTo){
    numDigits <- nchar(x)
    if (padTo != numDigits){
      leadingZeros <- paste(rep("0",(padTo-numDigits)),collapse="",sep="")
      x <- paste(leadingZeros,x,sep="")
    }
    return(x)
  }
  
  if(nrow(NWIS)>0){  
    for (i in 1:nrow(NWIS)){
      
      NWIS$pCode[i] <- padVariable(NWIS$pCode[i],5)
      NWIS$statCd[i] <- padVariable(NWIS$statCd[i],5)
      
      if(nchar(NWIS$siteID[i]) == 7){
        NWIS$siteID[i] <- padVariable(NWIS$siteID[i],8)
      }
      
      if(1 == i){
        NWISCalls <- with(NWIS, generateProcessNWISurl(siteID[i],pCode[i],colName[i],Statistic[i],Hours[i],statCd[i]))
      } else {
        NWISCalls <- append(NWISCalls,with(NWIS, generateProcessNWISurl(siteID[i],pCode[i],colName[i],Statistic[i],Hours[i],statCd[i])))
      }  
    }
    NWISPCodes <- unique(NWIS$pCode)
    NWISSites <- unique(NWIS$siteID)
    
  } else {
    
    NWISCalls <- NA
    NWISPCodes <- NA
    NWISSites <- NA
    NWIS <- NA    
  }
  
  if(nrow(GLCFS)>0){
    GLCFSSourceNum <- c(rep(0,12),rep(1,5),rep(2,3))
    names(GLCFSSourceNum) <- c("ci",
                               "eta",
                               "hi",
                               "uc",
                               "ui",
                               "utm",
                               "vc",
                               "vi",
                               "vtm",
                               "wvd",
                               "wvh",
                               "wvp",
                               "air_u",
                               "air_v",
                               "at",
                               "cl",
                               "dp",
                               "temp",
                               "u",
                               "v")
    GLCFS$sourceNum <- GLCFSSourceNum[GLCFS$pCode]
    
    for (i in 1:nrow(GLCFS)){
      site <- GLCFS$siteID[i]
      xPoint <- strsplit(site,":")[[1]][1]
      yPoint <- strsplit(site,":")[[1]][2]
      zPoint <- strsplit(site,":")[[1]][3]
      
      if(1 == i){
        GLCFSCalls <- with(GLCFS, generateProcessedGLCFSurl(xPoint,yPoint,zPoint,sourceNum[i],pCode[i],colName[i],Statistic[i],Hours[i],angle[i],vector[i]))    
      } else {
        GLCFSCalls <- append(GLCFSCalls,with(GLCFS, generateProcessedGLCFSurl(xPoint,yPoint,zPoint,sourceNum[i],pCode[i],colName[i],Statistic[i],Hours[i],angle[i],vector[i])))
      }  
    }
    GLCFSVars <- unique(GLCFS$pCode)
    GLCFSSources <- unique(GLCFS$sourceNum)
  }else{
    GLCFSCalls <- NA
    GLCFSVars <- NA
    GLCFSSources <- NA
    GLCFS <- NA
  }
  
  if(nrow(GDP)>0){
    for (i in 1:nrow(GDP)){

      stat <- GDP$Statistic[i]
      time <- GDP$Hours[i]
      shapefile <- GDP$StationName[i]
      shapefileFeature <- GDP$Descriptor[i]
      colName <- GDP$colName[i]

      if(1 == i){
        if(!is.na(stat) & !is.na(time)){
          GDPCalls <- paste("precip4",stat,time,sep=":")          
        } else {
          GDPCalls <- "precip4"
        }
        
        if(!is.na(colName)){
          GDPCalls <- paste(GDPCalls,colName,sep="!")
        } else {
          
          GDPCalls <- paste(GDPCalls,URLencode(paste(stat, 'over', time, "precip",sep=" ")),sep="!")
        }
        
      } else {
        
        if(!is.na(stat) & !is.na(time)){
          GDPCallsNew <- paste("precip4",stat,time,sep=":")          
        } else {
          GDPCallsNew <- "precip4"
        }
        
        if(!is.na(colName)){
          GDPCallsNew <- paste(GDPCallsNew,colName,sep="!")
        } else {          
          GDPCallsNew <- paste(GDPCallsNew,URLencode(paste(stat, 'over', time, "precip",sep=" ")),sep="!")
        }
        
        GDPCalls <- append(GDPCalls,GDPCallsNew)
      } 
    }

  } else {
    GDPCalls <- NA
    GDP <- NA
    shapefile <- NA
    shapefileFeature <- NA
  }
  
  if(nrow(PRECIP)>0){  
    for (i in 1:nrow(PRECIP)){
      site <- PRECIP$siteID[i]
      stat <- PRECIP$Statistic[i]
      time <- PRECIP$Hours[i]
      tIndex <- PRECIP$tIndex[i]
      colName <- PRECIP$colName[i]
      
      if(1 == i){
        if(!is.na(stat) & !is.na(time)){
          PRECIPCalls <- paste(site,tIndex,"precip3",stat,time,sep=":")          
        } else {
          PRECIPCalls <- paste(site,tIndex,"precip3","","",sep=":")
        }
        
        if(!is.na(colName)){
          PRECIPCalls <- paste(PRECIPCalls,colName,sep="!")
        } else {          
          PRECIPCalls <- paste(PRECIPCalls,URLencode(paste(stat, 'over', time, "precip",sep=" ")),sep="!")
        }
        
      } else {
        
        if(!is.na(stat) & !is.na(time)){
          PRECIPCallsNew <- paste(site,tIndex,"precip3",stat,time,sep=":")          
        } else {
          PRECIPCallsNew <- paste(site,tIndex,"precip3","","",sep=":")
        }
        
        if(!is.na(colName)){
          PRECIPCallsNew <- paste(PRECIPCallsNew,colName,sep="!")
        } else {          
          PRECIPCallsNew <- paste(PRECIPCallsNew,URLencode(paste(stat, 'over', time, "precip",sep=" ")),sep="!")
        }
        
        PRECIPCalls <- append(PRECIPCalls,PRECIPCallsNew)
      } 
    }
  } else {
    
    PRECIPCalls <- NA
    PRECIP <- NA
    
  }
  
  dataReturn <- list("NWISCalls" = NWISCalls,
                     "GLCFSCalls" = GLCFSCalls, 
                     "NWISPCodes" = NWISPCodes,
                     "NWISSites" = NWISSites,
                     "GLCFSVars" = GLCFSVars, 
                     "GLCFSSources" = GLCFSSources,
                     "NWIS" = NWIS,
                     "GLCFS" = GLCFS,
                     "GDP" = GDP,
                     "GDPCalls" = GDPCalls,
                     "PRECIPCalls" = PRECIPCalls,
                     "PRECIP" = PRECIP)
  
  return(dataReturn)
  
}