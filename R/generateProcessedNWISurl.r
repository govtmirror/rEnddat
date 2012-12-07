#' Get NWIS processed parts of URL for EnDDaT
#'
#' Get NWIS processed parts of URL for EnDDaT
#'
#' @param siteNumber string USGS site ID numbers 
#' @param pCode string 5 digit parameter code
#' @param statCd string 5 digit stat code
#' @param colName string column name
#' @param process string statistical process available processes are Mean,Min,Max,Sum,Diff,StDev
#' @param numHours integer number of hours to process
#' @return processedNWIScall string
#' @export
#' @examples
#' siteNumber <- '04024000'
#' parameterCd <- '00060'
#' statCd <- '00003'
#' colName <- 'Gage height [ft]'
#' process <- 'Mean'
#' numHours <- 6
#' firstReturn <- generateProcessNWISurl(siteNumber, parameterCd,statCd,colName,process,numHours)
generateProcessNWISurl <- function(siteNumber,pCode,colName,process,numHours,statCd){

  NWIScall <- generateNWISurl(siteNumber, pCode,statCd,colName)
  processedNWIScall <- addStatProcess(NWIScall, process, numHours,colName)
  return(processedNWIScall)
  
}