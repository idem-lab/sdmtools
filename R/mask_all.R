#' @title Mask all
#' @description Masks all `NA` cells across all layers, such that returned layers
#' have matching `NA` cells.
#'
#' @details
#' **Uses a ton of RAM and will break for larger rasters.**
#'
#'
#' @param rasts `SpatRaster` with `nlyr(rasts)` > 1 to mask
#' @param filename `character`to save output
#' @param overwrite `logical` overwrite existing `filename`?
#'
#' @return `SpatRaster`
#' @export
#'
#' @examples
#'
#' # Create some SpatRaster layers with non-matching NA cells
#' library(terra)
#' library(sdmtools)
#'
#' r <- c(
#'   example_raster(seed = 1),
#'   example_raster(seed = 2),
#'   example_raster(seed = 3)
#' )
#' rvals <- terra::values(r)
#' nas <- c(1:10, 105:120, 215:240)
#' rvals[nas] <- NA
#' r[] <- rvals
#'
#' # check if it pleases you to do so
#' # plot(r)
#' # mask out non-overlapping `NA` values in all layers
#' s <- mask_all(r)
#' s
#'
#'# plot(s)
mask_all <- function(
    rasts,
    filename = NULL,
    overwrite = FALSE
  ){

  if(!is.null(filename)){

    if(file.exists(filename)){
      warning(sprintf(
        "%s exists\nUsing existing file\nto re-generate, delete existing %s",
        filename,
        filename
      ))

      terra::rast(filename)
    }

  }

  rvs <- terra::values(rasts)

  naidx <- apply(rvs, 1, FUN = anyNA)

  rvs[naidx, 1:ncol(rvs)] <- NA

  rasts[] <- rvs

  if(!is.null(filename)){
    rasts <- sdmtools::writereadrast(
      rasts,
      filename,
      overwrite = overwrite
    )
  }

  rasts

}



