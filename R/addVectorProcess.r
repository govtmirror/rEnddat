#' Add vector processing to call
#'
#' Add vector processing to call
#'
#' @param urlSection string USGS site ID numbers 
#' @param vectorProcess string options are 'par' 'perp' 'angle' 'magnitude'.  If angle or magnitude, no beach angle required.
#' @param angle number beach angle in degrees from north. Default is 0
#' @param customColName string Column name if not auto-generated
#' @return vectorCall string
#' @export
#' @examples
#' xPoint <- 130
#' yPoint <- 13
#' zPoint <- -1
#' sourceNum <- 0
#' varName <- 'vc'
#' colName <- 'Northward velocity at surface'
#' 
#' glcfsReturn <- generateGLCFSurl(xPoint, yPoint,zPoint,sourceNum,varName,colName)
#' vectorProcess <- 'par'
#' angle <- 22.1
#' vectorReturn <- addVectorProcess(glcfsReturn, vectorProcess, angle)
addVectorProcess <- function(urlSection, vectorProcess, angle=0, customColName=""){
  
  urlSection <- strsplit(urlSection,"!")
  urlSec1 <- substr(urlSection[[1]][1],1,nchar(urlSection[[1]][1])-4)
  varName <- strsplit(urlSec1,":")
  varName <- varName[[1]][length(varName[[1]])]
  
  vNames <- c("u", "uc","utm","air_u","ui","wvh")
  names(vNames) <- c("v", "vc","vtm","air_v","vi","wvd")
  
  compName <- as.character(vNames[varName])
  
  urlSec1 <- paste(urlSec1,compName,vectorProcess,as.character(angle),sep=":")
  
  if(nchar(customColName) == 0){
    colName <- URLencode(paste(vectorProcess, URLdecode(urlSection[[1]][2]),sep=" "))
  } else {
    colName <- customColName
  }
  vectorCall <- paste(urlSec1,colName,sep="!")

  return(vectorCall)
  
}