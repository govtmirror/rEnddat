#' Get NWIS Data from EnDDaT
#'
#' Get NWIS Data from EnDDaT
#'
#' @param totalParams dataframe
#' @param baseReturn string
#' @return NWISData dataframe
#' @export
#' @examples
#' 
#' \dontrun{getNWISData(totalParams,baseReturn)}
getNWISData <- function(totalParams,baseReturn){

  dataRequestReturn <- dataRequest(totalParams)
  suppressWarnings(
    if (!is.na(dataRequestReturn['NWIS'][[1]])){
      
      NWISCalls <- unlist(dataRequestReturn['NWISCalls'],use.names=FALSE)  
#       uniquePcodes <- unlist(dataRequestReturn['NWISPCodes'],use.names=FALSE)
#       uniqueSites <- unlist(dataRequestReturn['NWISSites'],use.names=FALSE)
      
      NWIS <-dataRequestReturn['NWIS'][[1]]
      
      requestCombo <- unique(with(NWIS, data.frame(siteID, pCode, statCd)))
      
      NWISData <- data.frame()
      
      for (i in 1:nrow(requestCombo)){
        collapse <- paste(NWISCalls[which(requestCombo$pCode[i] == NWIS$pCode & requestCombo$siteID[i] == NWIS$siteID & requestCombo$statCd[i] == NWIS$statCd)],collapse="&")
        NWISurl <- paste(baseReturn,collapse,sep="&")
        message("Getting data: ",as.character(requestCombo$pCode[i]),":", as.character(requestCombo$siteID[i]),":", as.character(requestCombo$statCd[i]),"\n",sep="")
        possibleError <- tryCatch(
          getEnDDaTNWISData <- read.delim(  
            NWISurl, 
            header = TRUE, 
            dec=".", 
            sep='\t',
            fill = TRUE, 
            comment.char="#"),
          error=function(e) e
        )
        
        if(!inherits(possibleError, "error")){
          getEnDDaTNWISData$time <- as.POSIXct(getEnDDaTNWISData$time, "%m/%d/%Y %H:%M",tz="")
          if (!any(colnames(NWISData) == 'time')){
            NWISData <- getEnDDaTNWISData
          } else {
            NWISData <- mergeENDDAT(NWISData, getEnDDaTNWISData)
          }  
        } else {
          message("Data: ",as.character(requestCombo$pCode[i]),":", as.character(requestCombo$siteID[i]),":", as.character(requestCombo$statCd[i])," did not load properly \n",sep="")
        }
      }

    } else {
      NWISData <- NA
    }
  )
  return(NWISData)
  
}