#' Open csv requestData file
#'
#' Open csv requestData file
#'
#' @param totalParams dataframe
#' @return requestData list
#' @export
#' @examples
#' fileName <- "fischerParams.csv"
#' filePath <- "//igsarmewfsapa/projects/QW Monitoring Team/GLRI beaches/Modeling/Model development 2012"
#' totalParams <- getParamsFromFile(filePath,fileName)
#' requestData <- dataRequest(totalParams)
dataRequest <- function(totalParams){
  
  NWIS <- totalParams['NWIS' == totalParams$Source,]
  GLCFS <- totalParams['GLCFS' == totalParams$Source,]
  
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
  }else{
    NWISCalls <- NA
    NWISPCodes <- NA
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
  dataReturn <- list("NWISCalls" = NWISCalls,
                     "GLCFSCalls" = GLCFSCalls, 
                     "NWISPCodes" = NWISPCodes,
                     "GLCFSVars" = GLCFSVars, 
                     "GLCFSSources" = GLCFSSources,
                     "NWIS" = NWIS,
                     "GLCFS" = GLCFS)
  
  return(dataReturn)
  
}