#' Add statistical processing to call
#'
#' Add statistical processing to call
#'
#' @param urlSection string USGS site ID numbers 
#' @param process string options are Mean,Min,Max,Sum,Diff,StDev
#' @param numHours integer number of hours to process
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
addStatProcess <- function(urlSection, process, numHours){
  
  urlSection <- strsplit(urlSection,"!")
  urlSec1 <- paste(urlSection[[1]][1],process,as.character(numHours),sep=":")
  colName <- URLencode(paste(process, 'over', numHours,URLdecode(urlSection[[1]][2]),sep=" "))
  processCall <- paste(urlSec1,colName,sep="!")
  return(processCall)
  
}