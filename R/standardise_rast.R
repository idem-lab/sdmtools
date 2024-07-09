#' @title Standardise Raster
#' @description
#'
#' **Defunct**.
#'
#' DO NOT USE THIS FUNCTION
#'
#' Instead use `terra::scale`
#'
#' @param x A `SpatRaster` object.
#'
#' @return A `SpatRaster` objects with mean of zero and standard deviation of one.
#' @export
#'
#' @examples
#' r <- example_raster()
#'
#' standardise_rast(r)
#'
standardise_rast <- function(x){

  stop("This function will shortly be removed from sdmtools\nUse terra::scale instead")

}
