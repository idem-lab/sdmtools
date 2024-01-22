#' @title Raster plot with points
#' @description
#' Simple convenience function to plot points over a raster. Useful for quick data checks.
#'
#'
#' @param r `spatRaster` object
#' @param v `spatVector` object
#' @param pch  `integer ` point symbol. See `?par`
#' @param cex `numeric` point size multiplier. See `?par`
#'
#' @return graphical plot
#' @export
#'
#' @examples
#' rastpointplot(r,v)
rastpointplot <- function(
    r,
    v,
    pch = 16,
    cex = 0.5
){

  terra::plot(r)
  terra::points(v, pch = pch, cex = cex)

}
