\name{getGDPId}
\alias{getGDPId}
\title{Get GDP id for EnDDaT}
\usage{
  getGDPId(shapefile, endDate, startDate,
    config.featureAttrName = "Id",
    dataUrl = "dods://cida.usgs.gov/qa/thredds/dodsC/fixed/qpe/realtime/kmsr",
    datasetId = "1-hour_Quantitative_Precip_Estimate_surface_1_Hour_Accumulation")
}
\arguments{
  \item{shapefile}{string}

  \item{endDate}{string}

  \item{startDate}{string}

  \item{config.featureAttrName}{string}

  \item{dataUrl}{string}

  \item{datasetId}{string}
}
\value{
  list
}
\description{
  Get GDP id
}
\examples{
shapefile <- "upload:Redarrow"
endDate <- "2013-07-18"
startDate <- "2013-06-18"
shapefileFeature <- "AREA"
gdpID <- getGDPId(shapefile, endDate, startDate, shapefileFeature)
}

