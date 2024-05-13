#' @title temptif
#' @description Returns a temporary file with a `*.tif` extenstion
#'
#' @return `character`
#' @export
#'
#' @examples
#' temptif()
temptif <- function(){
  tempfile(fileext = ".tif")
}
