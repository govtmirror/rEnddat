#' Get GDP id for EnDDaT
#'
#' Get GDP id
#'
#' @param shapefile string
#' @param endDate string
#' @param startDate string
#' @param config.featureAttrName string
#' @param dataUrl string
#' @param datasetId string
#' @return list
#' @export
#' @import XML
#' @import RCurl
#' @examples
#' shapefile <- "upload:Redarrow"
#' endDate <- "2013-07-18"
#' startDate <- "2013-06-18"
#' shapefileFeature <- "AREA"
#' gdpID <- getGDPId(shapefile, endDate, startDate, shapefileFeature)
getGDPId <- function(shapefile, endDate, startDate, config.featureAttrName="Id",
                     dataUrl="dods://cida.usgs.gov/qa/thredds/dodsC/fixed/qpe/realtime/kmsr",
                     datasetId="1-hour_Quantitative_Precip_Estimate_surface_1_Hour_Accumulation"){

#   dataUrl <- "dods://cida.usgs.gov/qa/thredds/dodsC/fixed/qpe/realtime/kmsr"
#   datasetId <- "1-hour_Quantitative_Precip_Estimate_surface_1_Hour_Accumulation"
  
#   dataUrl <- "http://thredds.ucar.edu/thredds/dodsC/grib/NPVU/RFC/KMSR-North-Central-RFC/best"
#   datasetId <- "1-hour_Quantitative_Precip_Estimate_surface_1_Hour_Accumulation"
  
  
  statistic <- "MEAN"
  
  urlToPost <- "http://cida.usgs.gov/gdp/process/WebProcessingService"
  
  wpsExecute <- paste('<?xml version="1.0" encoding="UTF-8"?>',
                      '<wps:Execute xmlns:wps="http://www.opengis.net/wps/1.0.0" xmlns:ows="http://www.opengis.net/ows/1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" service="WPS" version="1.0.0" xsi:schemaLocation="http://www.opengis.net/wps/1.0.0 http://schemas.opengis.net/wps/1.0.0/wpsExecute_request.xsd">',
                      '  <ows:Identifier>gov.usgs.cida.gdp.wps.algorithm.FeatureWeightedGridStatisticsAlgorithm</ows:Identifier>',
                      '	<wps:DataInputs>',
                      '		<wps:Input>',
                      '			<ows:Identifier>FEATURE_COLLECTION</ows:Identifier>',
                      '			<wps:Reference xlink:href="http://igsarm-cida-javadev1.er.usgs.gov:8086/geoserver/wfs">',
                      '				<wps:Body>',
                      '					<wfs:GetFeature xmlns:gml="http://www.opengis.net/gml" xmlns:ogc="http://www.opengis.net/ogc" xmlns:wfs="http://www.opengis.net/wfs" outputFormat="text/xml; subtype=gml/3.1.1" service="WFS" version="1.1.0" xsi:schemaLocation="http://www.opengis.net/wfs http://igsarm-cida-javadev1.er.usgs.gov:8086/geoserver/schemas/wfs/1.1.0/wfs.xsd">',
                      ' 					<wfs:Query typeName="', shapefile,'">',
                      "							<wfs:PropertyName>the_geom</wfs:PropertyName>",
                      "							<wfs:PropertyName>", config.featureAttrName, "</wfs:PropertyName>",
                      "						</wfs:Query>",
                      "					</wfs:GetFeature>",
                      "				</wps:Body>",
                      "			</wps:Reference>",
                      "		</wps:Input>",
                      "		<wps:Input>",
                      "			<ows:Identifier>FEATURE_ATTRIBUTE_NAME</ows:Identifier>",
                      "			<wps:Data>",
                      "				<wps:LiteralData>", config.featureAttrName, "</wps:LiteralData>",
                      "			</wps:Data>",
                      "		</wps:Input>",
                      "		<wps:Input>",
                      "			<ows:Identifier>DATASET_URI</ows:Identifier>",
                      "			<wps:Data>",
                      "				<wps:LiteralData>" , dataUrl , "</wps:LiteralData>",
                      "			</wps:Data>",
                      "		</wps:Input>",
                      "		<wps:Input>",
                      "			<ows:Identifier>DATASET_ID</ows:Identifier>",
                      "			<wps:Data>",
                      "				<wps:LiteralData>" , datasetId , "</wps:LiteralData>",
                      "			</wps:Data>",
                      "		</wps:Input>",
                      "		<wps:Input>",
                      "			<ows:Identifier>TIME_START</ows:Identifier>",
                      "			<wps:Data>",
                      "				<wps:LiteralData>" , startDate , "T00:00:00.000Z</wps:LiteralData>", 
                      "			</wps:Data>",
                      "		</wps:Input>",
                      "		<wps:Input>",
                      "			<ows:Identifier>TIME_END</ows:Identifier>",
                      "			<wps:Data>",
                      "				<wps:LiteralData>" , endDate , "T23:59:59.000Z</wps:LiteralData>", 
                      "			</wps:Data>",
                      "		</wps:Input>",
                      "		<wps:Input>",
                      "			<ows:Identifier>REQUIRE_FULL_COVERAGE</ows:Identifier>",
                      "			<wps:Data>",
                      "				<wps:LiteralData>true</wps:LiteralData>",
                      "			</wps:Data>",
                      "		</wps:Input>",
                      "		<wps:Input>",
                      "			<ows:Identifier>DELIMITER</ows:Identifier>",
                      "			<wps:Data>",
                      "				<wps:LiteralData>COMMA</wps:LiteralData>",
                      "			</wps:Data>",
                      "		</wps:Input>",
                      "  	<wps:Input>",
                      "			<ows:Identifier>STATISTICS</ows:Identifier>",
                      "			<wps:Data>",
                      "				<wps:LiteralData>" , statistic , "</wps:LiteralData>",
                      "			</wps:Data>",
                      "		</wps:Input>",
                      "		<wps:Input>",
                      "			<ows:Identifier>GROUP_BY</ows:Identifier>",
                      "			<wps:Data>",
                      "				<wps:LiteralData>STATISTIC</wps:LiteralData>",
                      "			</wps:Data>",
                      "		</wps:Input>",
                      "		<wps:Input>",
                      "			<ows:Identifier>SUMMARIZE_TIMESTEP</ows:Identifier>",
                      "			<wps:Data>",
                      "				<wps:LiteralData>false</wps:LiteralData>",
                      "			</wps:Data>",
                      "		</wps:Input>",
                      "		<wps:Input>",
                      "			<ows:Identifier>SUMMARIZE_FEATURE_ATTRIBUTE</ows:Identifier>",
                      "			<wps:Data>",
                      "				<wps:LiteralData>false</wps:LiteralData>",
                      "			</wps:Data>",
                      "		</wps:Input>",
                      "	</wps:DataInputs>",
                      "	<wps:ResponseForm>",
                      '		<wps:ResponseDocument storeExecuteResponse= "true" status="true">',
                      '			<wps:Output asReference="true">',
                      "				<ows:Identifier>OUTPUT</ows:Identifier>",
                      "			</wps:Output>",
                      "		</wps:ResponseDocument>",
                      "	</wps:ResponseForm>",
                      "</wps:Execute>",sep="")
  
  myheader=c(Connection="close", 
             'Content-Type' = "application/xml",
             'Content-length' =nchar(wpsExecute))
  
  data =  getURL(url = urlToPost,
                 postfields=wpsExecute,
                 httpheader=myheader,
                 verbose=TRUE)
  
  xmltext  <- xmlTreeParse(data, asText = TRUE,useInternalNodes=TRUE)
  
  response <- xmlRoot(xmltext)
  responseNS <- xmlNamespaceDefinitions(response, simplify = TRUE)  
  statusLocation <- xmlGetAttr(response,"statusLocation")
  
  repeat{
    checkForComplete =  getURL(url = statusLocation, verbose=TRUE)
    checkForCompleteResponse  <- xmlTreeParse(checkForComplete, asText = TRUE,useInternalNodes=TRUE)
    
    checkResponseNS <- xmlNamespaceDefinitions(checkForCompleteResponse, simplify = TRUE)  
    
    root <- xmlRoot(checkForCompleteResponse)
    status <- sapply(xmlChildren(root[["Status"]]), xmlName)

    cat(status, "\n")
    
    if ("ProcessSucceeded" == status){
      root <- xmlRoot(checkForCompleteResponse)
      gdpURL <- as.character(xpathApply(root, "//@href", namespaces = checkResponseNS)[[1]])
      gdpID <- strsplit(gdpURL, "id=")[[1]][2]
      break
    } else if ("ProcessFailed" == status){
      gdpID <- "Process Failed"
      gdpURL <- "Process Failed"
      break
    }
    
    Sys.sleep(5)
  }
  
  return(list(gdpID=gdpID, gdpURL=gdpURL))
}