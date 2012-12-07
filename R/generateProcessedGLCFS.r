#' Get GLCFS processed parts of URL for EnDDaT
#'
#' Get GLCFS processed parts of URL for EnDDaT
#'
#' @param xPoint string GLCFS x index
#' @param yPoint string GLCFS y index
#' @param zPoint string GLCFS z index
#' @param colName string column name
#' @param sourceNum integer defines which data source.  Possibilities: (0,1,2) 
#' @param varName string variable name
#' @param numHours integer number of hours 
#' @param vector string defines vector process.  Possibilities: 'perp' or 'par'
#' @param angle number angle from north
#' @param process process string statistical process available processes are Mean,Min,Max,Sum,Diff,StDev
#' @return processedGLCFScall string
#' @export
#' @examples
#' xPoint <- 130
#' yPoint <- 13
#' zPoint <- -1
#' sourceNum <- 0
#' varName <- 'vc'
#' colName <- 'Northward velocity at surface'
#' numHours <- 12
#' process <- 'Mean'
#' angle <- 26.2
#' vector <- 'perp'
#' 
#' firstReturn <- generateProcessedGLCFSurl(xPoint, yPoint,zPoint,sourceNum,varName,colName,process, numHours,angle,vector)
generateProcessedGLCFSurl <- function(xPoint, yPoint,zPoint,sourceNum,varName,colName, process, numHours,angle=NA,vector=NA){
  
  GLCFS <- generateGLCFSurl(xPoint, yPoint,zPoint,sourceNum,varName,colName)
  
  
  if (!is.na(angle) & !is.na(vector)){
    processed <- addVectorProcess(GLCFS, vector, angle)
    processed <- addStatProcess(processed, process, numHours)
  } else {
    processed <- addStatProcess(GLCFS, process, numHours)
  }
  
  
  return(processed)
  
}