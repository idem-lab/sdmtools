#' Create an example mask within a given raster
#'
#' @return A `spatRaster`
#' @param raster generated from example_raster for example
#' @param pc_threshold A threshold percentile to divide mask / non mask elements
#' @export
#'
#' @examples
#' example_mask(example_raster(), pc_threshold=0.5)
example_mask <- function(raster, pc_threshold = NULL) {

  # get the empirical cumulative distribution of the raster values
  ecdf <- ecdf(terra::values(raster))

  # identify the value corresponding to desired
  threshold_value <- quantile(values(raster),
                              pc_threshold,
                              na.rm=TRUE)

  # reassign cells that are below the threshold as outside mask
  raster[raster[] <= threshold_value] <- NA

  # return this raster as the mask
  raster

}
