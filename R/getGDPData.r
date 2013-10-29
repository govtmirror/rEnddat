#' Get GDP id for EnDDaT
#'
#' Get GDP id
#'
#' @param totalParams dataframe
#' @param baseReturn string
#' @param archive logical If data is being requested in the several 2 weeks (currently goes back to 5 months), set to FALSE, otherwise set to TRUE (the default). Be aware, there is a gap between the real-time and archive.
#' @param endPosition character date in YYYY-MM-DD
#' @param beginPosition character start date in YYYY-MM-DD
#' @return GDPData dataframe
#' @export
#' @import XML
#' @import RCurl
#' @examples
#' \dontrun{getGDPData(totalParams,baseReturn,archive=FALSE)}
getGDPData <- function(totalParams,baseReturn,archive=TRUE, endPosition, beginPosition){
  
  dataRequestReturn <- dataRequest(totalParams)
  
  if(!archive){
    #This gets real-time data for greater than 2 weeks, but not 100% reliable...yet
    dataUrl <- "dods://cida.usgs.gov/thredds/rfc_qpe/dodsC/fixed/qpe/realtime/kmsr.html"
#     dataUrl="dods://cida.usgs.gov/qa/thredds/dodsC/fixed/qpe/realtime/kmsr"
    datasetId <- "1-hour_Quantitative_Precip_Estimate_surface_1_Hour_Accumulation"
    #This is officially what we should use, will only ever be 2 weeks:
#     dataUrl="dods://thredds.ucar.edu/thredds/dodsC/grib/NPVU/RFC/KMSR-North-Central-RFC/best"
#     datasetId="1-hour_Quantitative_Precip_Estimate_surface_1_Hour_Accumulation"
  } else {
#     dataUrl="dods://cida.usgs.gov/qa/thredds/dodsC/RFC/QPE/KMSR"
    dataUrl <- "dods://cida.usgs.gov/thredds/rfc_qpe/dodsC/fixed/qpe/realtime/kmsr"
#     datasetId="prcp"
    datasetId <- "1-hour_Quantitative_Precip_Estimate_surface_1_Hour_Accumulation"
  }
  suppressWarnings(
    if (!is.na(dataRequestReturn['GDP'][[1]])){
      GDPCalls <- unlist(dataRequestReturn['GDPCalls'],use.names=FALSE)

      GDP <- dataRequestReturn['GDP'][[1]]
      
      shapefile <- unique(GDP$StationName)
      shapefileFeature <- unique(GDP$Descriptor)
      
      if(length(shapefile) > 1 | length(shapefileFeature) > 1){
        
        stop("EnDDaT currently only supports 1 shapefile request")
        
      } else {

        gdpID <- getGDPId(shapefile, endPosition, beginPosition, shapefileFeature,dataUrl,datasetId)
        
        GDPurl <- paste(baseReturn, "&gdpId=collection:MEAN:",gdpID$gdpID, sep="")
        collapse <- paste("GDP=",GDPCalls,collapse="&",sep="")
        GDPurl <- paste(GDPurl,collapse,sep="&")
        
        GDPData <- read.delim(  
                    GDPurl, 
                    header = TRUE, 
                    dec=".", 
                    sep='\t',
                    fill = TRUE, 
                    comment.char="#")  
        
  
        GDPData$time <- as.POSIXct(GDPData$time, "%m/%d/%Y %H:%M",tz="")

      }
    } else {
      GDPData <- NA
    }
  )
  return(GDPData)
  
}