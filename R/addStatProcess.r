#' Add statistical processing to call
#'
#' Add statistical processing to call
#'
#' @param urlSection string USGS site ID numbers 
#' @param process string options are Mean,Min,Max,Sum,Diff,StDev
#' @param numHours integer number of hours to process
#' @param customColName string Column name if not auto-generated
#' @return processCall string
#' @export
#' @examples
#' siteNumber <- '04024000'
#' parameterCd <- '00060'
#' statCd <- '00003'
#' colName <- 'Gage height [ft]'
#' 
#' firstCall <- generateNWISurl(siteNumber, parameterCd,statCd,colName)
#' process <- 'Mean'
#' numHours <- 6
#' firstReturn <- addStatProcess(firstCall, process, numHours)
addStatProcess <- function(urlSection, process, numHours,customColName=""){
  
  urlSection <- strsplit(urlSection,"!")
  
  if (!is.na(process) & !is.na(numHours)){
    urlSec1 <- paste(urlSection[[1]][1],process,as.character(numHours),sep=":")
    if(nchar(customColName) == 0){
      colName <- URLencode(paste(process, 'over', numHours,URLdecode(urlSection[[1]][2]),sep=" "))
    } else {
      colName <- customColName
    }
  } else {
    urlSec1 <- paste(urlSection[[1]][1],":",":",sep="")
    if(nchar(customColName) == 0){
      colName <- URLencode(paste("raw",URLdecode(urlSection[[1]][2]),sep=" "))
    } else {
      colName <- customColName
    }
  }
  
  processCall <- paste(urlSec1,colName,sep="!")
  return(processCall)
  
}