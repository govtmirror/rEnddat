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
      uniquePcodes <- unlist(dataRequestReturn['NWISPCodes'],use.names=FALSE)
      uniqueSites <- unlist(dataRequestReturn['NWISSites'],use.names=FALSE)
      
      NWIS <-dataRequestReturn['NWIS'][[1]]
      
      
      for (i in 1:length(uniquePcodes)){
        for (j in 1:length(uniqueSites)){
          collapse <- paste(NWISCalls[which(uniquePcodes[i] == NWIS$pCode & uniqueSites[j] == NWIS$siteID)],collapse="&")
          NWISurl <- paste(baseReturn,collapse,sep="&")
          cat(uniquePcodes[i],": ",system.time(
            getEnDDaTNWISData <- read.delim(  
              NWISurl, 
              header = TRUE, 
              dec=".", 
              sep='\t',
              fill = TRUE, 
              comment.char="#")
          )[3],"s. elapse\n",sep="")
          getEnDDaTNWISData$time <- as.POSIXct(getEnDDaTNWISData$time, "%m/%d/%Y %H:%M",tz="")
          if (1 == i){
            NWISData <- getEnDDaTNWISData
          } else {
            NWISData <- mergeENDDAT(NWISData, getEnDDaTNWISData)
          }
        }
      }
    } else {
      NWISData <- NA
    }
  )
  return(NWISData)
  
}