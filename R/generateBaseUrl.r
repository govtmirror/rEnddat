#' Generate baseURL for EnDDaT
#'
#' Generate baseURL for EnDDaT
#'
#' @param beachName string optional
#' @param beginPosition string 'YYYY-MM-DD' optional
#' @param endPosition string 'YYYY-MM-DD' optional
#' @param tzone string hour_abbreviation required, default is '-6_CST'
#' @param lake string required, default is 'michigan'
#' @param beachLat string optional
#' @param beachLon string  optional
#' @param filter string optional
#' @param gap int optional
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
#' FischerFilterID <- "0925af38-d570-402f-a6ed-1e25f0554364"
#' gap <- 6
#' baseReturn <- generateBaseUrl(beachName, beginPosition,endPosition,tzone,lake,beachLat,beachLon,FischerFilterID,gap)
generateBaseUrl <- function(beachName="", beginPosition="",endPosition="",tzone="-6_CST",lake='michigan',beachLat="",beachLon="",filter="",gap=""){
  
  beachName <- paste('BeachName',beachName,sep="=")
  beginPosition <- paste('beginPosition', beginPosition,sep="=")
  endPosition <- paste('endPosition', endPosition,sep="=")
  tzone <- paste('TZ', tzone,sep="=")
  lake <- paste('Lake',lake,sep="=")
  beachLat <- paste('BeachLat',beachLat,sep="=")
  beachLon <- paste('BeachLon',beachLon,sep="=")
  filter <- paste('filterId',filter,sep="=")
  gap <- paste('timeInt',gap,sep="=")

  baseURL <- "http://cida.usgs.gov/enddat/service/execute?style=tab&download=on&DateFormat=Excel"
  
  baseURL <- paste(baseURL, beachName, beginPosition, endPosition, tzone, lake, beachLat, beachLon, filter, gap, sep="&")
  baseURL <- URLencode(baseURL)
  return(baseURL)
  
}