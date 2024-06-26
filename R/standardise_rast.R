#' @title Standardise Raster
#' @description
#' Standardises `SpatRaster` objects to mean of zero and standard deviation of one.
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

  vals <- terra::values(x)
  meanx <- mean(vals, na.rm = TRUE)
  sdx <- stats::sd(vals, na.rm = TRUE)

  (x - meanx)/sdx

}
