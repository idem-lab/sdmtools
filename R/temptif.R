#' @title temptif
#' @description Returns a temporary file with a `*.tif` extenstion
#'
#' @return
#' @export
#'
#' @examples
#' temptif()
temptif <- function(){
  tempfile(fileext = ".tif")
}
