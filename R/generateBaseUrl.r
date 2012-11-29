#' Generate baseURL for EnDDaT
#'
#' Generate baseURL for EnDDaT
#'
#' @param beachName string
#' @param beginPosition string 'YYYY-MM-DD'
#' @param endPosition string 'YYYY-MM-DD'
#' @param tzone string hour_abbreviation
#' @param lake string
#' @param beachLat string
#' @param beachLon string 
#' @return baseURL string
#' @export
#' @examples
#' beachName <- 'Sample Beach'
#' beginPosition <- '2006-10-02'
#' endPosition <- '2006-10-05'
#' tzone <- '-5_CDT'
#' lake <- 'michigan'
#' beachLat <- ''
#' beachLon <- ''
#' 
#' baseReturn <- generateBaseUrl(beachName, beginPosition,endPosition,tzone,lake,beachLat,beachLon)
generateBaseUrl <- function(beachName, beginPosition,endPosition,tzone,lake,beachLat,beachLon){
  
  beachName <- paste('BeachName',beachName,sep="=")
  beginPosition <- paste('beginPosition', beginPosition,sep="=")
  endPosition <- paste('endPosition', endPosition,sep="=")
  tzone <- paste('TZ', tzone,sep="=")
  lake <- paste('Lake',lake,sep="=")
  beachLat <- paste('BeachLat',beachLat,sep="=")
  beachLon <- paste('BeachLon',beachLon,sep="=")

  baseURL <- "http://cida.usgs.gov/enddat/service/execute?style=tab&download=on&DateFormat=Excel"
  
  baseURL <- paste(baseURL, beachName, beginPosition, endPosition, tzone, lake, beachLat, beachLon, sep="&")
  baseURL <- URLencode(baseURL)
  return(baseURL)
  
}