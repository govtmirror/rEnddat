#' Get PRECIP Data from EnDDaT
#'
#' Get PRECIP Data from EnDDaT
#'
#' @param totalParams dataframe
#' @param baseReturn string
#' @return PRECIPData dataframe
#' @export
#' @examples
#' 
#' \dontrun{getPRECIPData(totalParams,baseReturn)}
getPRECIPData <- function(totalParams,baseReturn){
  
  dataRequestReturn <- dataRequest(totalParams)
  suppressWarnings(
    if (!is.na(dataRequestReturn['PRECIP'][[1]])){
      PRECIPCalls <- unlist(dataRequestReturn['PRECIPCalls'],use.names=FALSE)  
    
      PRECIP <-dataRequestReturn['PRECIP'][[1]]
      
      PRECIPData <- data.frame()
      uniqueSites <- unique(PRECIP$siteID)
      
      for (i in 1:length(uniqueSites)){

        collapse <- paste("Precip","=",PRECIPCalls[which(PRECIP$siteID %in% uniqueSites[i])],collapse="&",sep="")
        
        PRECIPurl <- paste(baseReturn,collapse ,sep="&")
        message("Getting data: ",as.character(uniqueSites[i]),"\n",sep="")
        possibleError <- tryCatch(
          getEnDDaTPRECIPData <- read.delim(  
            PRECIPurl, 
            header = TRUE, 
            dec=".", 
            sep='\t',
            fill = TRUE, 
            comment.char="#"),
          error=function(e) e
        )
        
        if(!inherits(possibleError, "error")){
          getEnDDaTPRECIPData$time <- as.POSIXct(getEnDDaTPRECIPData$time, "%m/%d/%Y %H:%M",tz="")
          if (!any(colnames(PRECIPData) == 'time')){
            PRECIPData <- getEnDDaTPRECIPData
          } else {
            PRECIPData <- mergeENDDAT(PRECIPData, getEnDDaTPRECIPData)
          }  
        } else {
          message("Data: ",as.character(uniqueSites[i])," did not load properly \n",sep="")
        }
      }
      
    } else {
      PRECIPData <- NA
    }
  )
  return(PRECIPData)
  
}