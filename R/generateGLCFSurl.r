#' Get GLCFS parts of URL for EnDDaT
#'
#' Get GLCFS parts of URL for EnDDaT
#'
#' @param xPoint string GLCFS x index
#' @param yPoint string GLCFS y index
#' @param zPoint string GLCFS z index
#' @param colName string column name
#' @param sourceNum integer (0,1,2) defines which data source
#' @param varName string variable name
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