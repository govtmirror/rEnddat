#' Get GLCFS parts of URL for EnDDaT
#'
#' Get GLCFS parts of URL for EnDDaT
#'
#' @param siteNumber string USGS site ID numbers 
#' @param pCode string 5 digit parameter code
#' @param statCd string 5 digit stat code
#' @param colName string column name
#' @return GLCFScall string
#' @export
#' @examples
#' xPoint <- 130
#' yPoint <- 13
#' zPoint <- -1
#' sourceNum <- 0
#' varName <- 'vc'
#' colName <- 'Northward velocity at surface'
#' 
#' firstReturn <- generateGLCFSurl(xPoint, yPoint,zPoint,sourceNum,varName,colName)
generateGLCFSurl <- function(xPoint, yPoint,zPoint,sourceNum,varName,colName){
  
  GLCFScall <- paste(xPoint, yPoint,zPoint,sourceNum,varName,sep=":")
  GLCFScall <- paste(GLCFScall,":::0",sep="")
  colName <- URLencode(colName)
  GLCFScall <- paste(GLCFScall,colName,sep="!")
  GLCFScall <- paste("GRID",GLCFScall,sep="=")
  return(GLCFScall)
  
}