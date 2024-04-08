#' @title Standardise Raster
#' @description
#' Standardises `spatRaster` objects to mean of zero and standard deviation of one.
#'
#' @param x A `spatRaster` object.
#'
#' @return A `spatRaster` objects with mean of zero and standard deviation of one.
#' @export
#'
#' @examples
#' r <- example_rast()
#'
#' standardise_rast(r)
#'
standardise_rast <- function(x){

  vals <- terra::values(x)
  meanx <- mean(vals, na.rm = TRUE)
  sdx <- sd(vals, na.rm = TRUE)

  (x - meanx)/sdx

}
