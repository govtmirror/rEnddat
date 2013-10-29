#' Get EnDDaT data
#'
#' Get EnDDaT data
#'
#' @param totalParams dataframe
#' @param baseReturn string
#' @param archive logical if requesting historical GDP data, set to TRUE, otherwise FALSE.
#' @param endPosition character YYYY-MM-DD
#' @param beginPosition character YYYY-MM-DD
#' @return EnDDaTData dataframe
#' @export
#' @examples
#' \dontrun{getEnDDaTData(totalParams,baseReturn)}
getEnDDaTData <- function(totalParams,baseReturn,archive=TRUE,endPosition,beginPosition){
  
  dataRequestReturn <- dataRequest(totalParams)
  
  
  suppressWarnings(
    if (!is.na(dataRequestReturn['NWIS'][[1]])){
      possibleError <- tryCatch(
        NWISData <- getNWISData(totalParams,baseReturn),
        error=function(e) e
      )
      if(inherits(possibleError, "error")){
        NWISData <- NA
      }
    } else {
      NWISData <- NA
    }
  )
  
  suppressWarnings(
    if (!is.na(dataRequestReturn['GLCFS'][[1]])){
      possibleError <- tryCatch(
        GLCFSData <- getGLCFSData(totalParams,baseReturn),
        error=function(e) e
      )
      if(inherits(possibleError, "error")){
        GLCFSData <- NA
      }
    } else {
      GLCFSData <- NA
    })
  
  suppressWarnings(
    if (!is.na(dataRequestReturn['GDP'][[1]])){
      possibleError <- tryCatch(
        GDPData <- getGDPData(totalParams,baseReturn,archive=archive,endPosition,beginPosition),
        error=function(e) e
      )
      if(inherits(possibleError, "error")){
        GDPData <- NA
      }
    } else {
      GDPData <- NA
    })
  
  suppressWarnings(
    if (!is.na(dataRequestReturn['PRECIP'][[1]])){
      possibleError <- tryCatch(
        PrecipPointData <- getPRECIPData(totalParams, baseReturn),
        error=function(e) e
      )
      if(inherits(possibleError, "error")){
        PrecipPointData <- NA
      }
    } else {
      PrecipPointData <- NA
    })
  
  EnDDaTData <- merge(NWISData, GLCFSData,all=TRUE)
  EnDDaTData <- merge(EnDDaTData , GDPData,all=TRUE)
  EnDDaTData <- merge(EnDDaTData , PrecipPointData,all=TRUE)
  
  EnDDaTData$x <- NULL
  EnDDaTData$y <- NULL
  
  return(EnDDaTData)
  
}