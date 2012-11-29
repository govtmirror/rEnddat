#' Add vector processing to call
#'
#' Add vector processing to call
#'
#' @param urlSection string USGS site ID numbers 
#' @param vectorProcess string options are 'par' 'perp' 'angle' 'magnitude'.  If angle or magnitude, no beach angle required.
#' @param angle number beach angle in degrees from north. Default is 0.
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
addVectorProcess <- function(urlSection, vectorProcess, angle=0){
  

  return(vectorCall)
  
}