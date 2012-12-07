#' Get GLCFS Data from EnDDaT
#'
#' Get GLCFS Data from EnDDaT
#'
#' @param totalParams dataframe
#' @param baseReturn string
#' @return GLCFSData dataframe
#' @export
#' @examples
#' 
#' \dontrun{getGLCFSData(totalParams,baseReturn)}
getGLCFSData <- function(totalParams,baseReturn){
  
  dataRequestReturn <- dataRequest(totalParams)
  GLCFSCalls <- unlist(dataRequestReturn['GLCFSCalls'],use.names=FALSE)
  uniqueSources <- unlist(dataRequestReturn['GLCFSSources'],use.names=FALSE)
  uniqueVariables <- unlist(dataRequestReturn['GLCFSVars'],use.names=FALSE)
  GLCFS <- dataRequestReturn['GLCFS'][[1]]
  
  for (i in 1:length(uniqueVariables)){
    collapse <- paste(GLCFSCalls[which(uniqueVariables[i]==GLCFS$pCode)],collapse="&")
    GLCFSurl <- paste(baseReturn,collapse,sep="&")
    cat(uniqueVariables[i],": ",system.time(
      getEnDDaTGLCFSData <- read.delim(  
        GLCFSurl, 
        header = TRUE, 
        dec=".", 
        sep='\t',
        fill = TRUE, 
        comment.char="#")  
    )[3],"s. elapse\n",sep="")
    getEnDDaTGLCFSData$time <- as.POSIXct(getEnDDaTGLCFSData$time, "%m/%d/%Y %H:%M",tz="")
    if (1 == i){
      GLCFSData <- getEnDDaTGLCFSData
    } else {
      GLCFSData <- mergeENDDAT(GLCFSData, getEnDDaTGLCFSData)
    }
  }

  return(GLCFSData)
  
}