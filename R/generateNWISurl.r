#' Get NWIS parts of URL for EnDDaT
#'
#' Get NWIS parts of URL for EnDDaT
#'
#' @param siteNumber string USGS site ID numbers 
#' @param pCode string 5 digit parameter code
#' @param statCd string 5 digit stat code
#' @param colName string column name
#' @return NWIScall string
#' @export
#' @examples
#' siteNumber <- '04024000'
#' parameterCd <- '00060'
#' statCd <- '00003'
#' colName <- 'Gage height [ft]'
#' 
#' firstReturn <- generateNWISurl(siteNumber, parameterCd,statCd,colName)
#' secondReturn <-generateNWISurl('04010500', '00010','00001','Temperature C')
generateNWISurl <- function(siteNumber,pCode,statCd,colName){
  
  NWIScall <- paste(siteNumber,pCode,statCd,sep=":")
  colName <- URLencode(colName)
  NWIScall <- paste(NWIScall,colName,sep="!")
  NWIScall <- paste("NWIS",NWIScall,sep="=")
  return(NWIScall)
  
}