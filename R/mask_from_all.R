#' @title Create mask from raster layers
#' @description
#' Creates a mask where a cell in any layer of `r` that is `NA` will be returned
#' as `NA`.
#'
#' @details
#' Similar in intention to `mask_all`, but (a) will work on larger rasters
#' because it only holds the values of a single layer in memory at a time, and
#' (b) returns a mask layer, rather than masking each layer in `r`.
#' **Can be very slow**
#'
#'
#' @param r `SpatRaster` with >1 layer.
#'
#' @return `SpatRaster` with values `NA` or 1.
#' @export
#'
#' @examples
#' r <- example_raster(seed = 10)
#' s <- example_raster(seed = 11)
#'
#' r[10:20] <- NA
#'
#' s[5:15] <- NA
#'
#' q <- mask_from_all(c(r,s))
#'
#' library("terra")
#' plot(c(r,s,q))
#'
mask_from_all <- function(r){

  j <- terra::nlyr(r)

  if(j == 1){stop("Must have >1 layer")}

  k <- which(is.na(terra::values(r[[1]])))

  for(i in 2:j){

    a <- which(is.na(terra::values(r[[i]])))

    b <- c(k, a)

    d <- duplicated(b)

    k <- b[!d]

  }

  z <- r[[1]]

  z[] <- 1
  z[k] <- NA

  z

}
