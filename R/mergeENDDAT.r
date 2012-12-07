#' Merge EnDDaT dataframes
#'
#' Merge EnDDaT dataframes
#'
#' @param DF1 dataframe
#' @param DF2 dataframe
#' @return mergedDF dataframe
#' @export
#' @examples
#' DF1 <- data.frame(time=c(1,2,3), a=c(1,4,8), b=c(2,6,9))
#' DF2 <- data.frame(time=c(1,2,4), a=c(1,4,8), c=c(2,6,9))
#' mergedDF <- mergeENDDAT(DF1,DF2)
mergeENDDAT <- function(DF1, DF2){

  mergedDF <- merge(DF1, DF2,all=TRUE)

  return(mergedDF)
  
}