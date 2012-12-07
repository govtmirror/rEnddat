#' Get EnDDaT requests from file
#'
#' Get EnDDaT requests from file
#'
#' @param filePath string local path to file
#' @param fileName string file name
#' @return totalParams dataframe
#' @export
#' @examples
#' 
#' \dontrun{getParamsFromFile(filePath,fileName)}
getParamsFromFile <- function(filePath,fileName){
  
  fullPath <- paste(filePath,fileName,sep="/")
  totalParams <- read.csv(fullPath,header=TRUE,stringsAsFactors=FALSE)
  
  return(totalParams)
  
}