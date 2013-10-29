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
  suppressWarnings(
    if (!is.na(dataRequestReturn['GLCFS'][[1]])){
      GLCFSCalls <- unlist(dataRequestReturn['GLCFSCalls'],use.names=FALSE)
      uniqueSources <- unlist(dataRequestReturn['GLCFSSources'],use.names=FALSE)
      uniqueVariables <- unlist(dataRequestReturn['GLCFSVars'],use.names=FALSE)
      GLCFS <- dataRequestReturn['GLCFS'][[1]]
      GLCFSData <- data.frame()
#       for (i in 1:length(GLCFSCalls)){
      for (i in 1:length(uniqueVariables)){
        collapse <- paste(GLCFSCalls[which(uniqueVariables[i]==GLCFS$pCode)],collapse="&")
#         GLCFSurl <- paste(baseReturn,GLCFSCalls[i],sep="&")
        GLCFSurl <- paste(baseReturn,collapse,sep="&")
        message("Getting data: ",uniqueVariables[i],"\n",sep="")
        possibleError <- tryCatch(  
          getEnDDaTGLCFSData <- read.delim(  
            GLCFSurl, 
            header = TRUE, 
            dec=".", 
            sep='\t',
            fill = TRUE, 
            comment.char="#"),
          error=function(e) e 
        )
        
        if(!inherits(possibleError, "error")){
          getEnDDaTGLCFSData$time <- as.POSIXct(getEnDDaTGLCFSData$time, "%m/%d/%Y %H:%M",tz="")
          if (!any(colnames(GLCFSData) == 'time')){
            GLCFSData <- getEnDDaTGLCFSData
          } else {
            GLCFSData <- mergeENDDAT(GLCFSData, getEnDDaTGLCFSData)
          }
        } else {
          message("Data: ",uniqueVariables[i]," did not load properly \n",sep="")
        }
      }
    } else {
      GLCFSData <- NA
    }
  )
  return(GLCFSData)
  
}