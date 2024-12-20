#' @title Standardise raster
#' @description Standardises all layers in a `SpatRaster` to a scale of 0-1,
#' by dividing by the maximum value in each layer. *Only operates by layer*
#'
#' @param x `SpatRaster` to standardise
#' @param reverse `logical` if `TRUE` will subtract standardised values from 1
#' @param filename Optional `character` path and filename to write output
#' @param overwrite `logical` if `TRUE` will overwrite `filename`
#'
#' @return A `SpatRaster` with range 0-1
#' @export
#'
#' @details
#' Will break for non-numeric rasters
#'
#'
#' @examples
#' example_raster(seed = 3010) |>
#'   std_rast(reverse = TRUE)
std_rast <- function(x, reverse = FALSE, filename = NULL, overwrite = TRUE){
  vals <- terra::values(x)

  nvs <- apply(
    vals,
    MARGIN = 2,
    FUN = function(x){
      x/max(x, na.rm = TRUE)
    }
  )

  r <- x

  if(reverse){
    nvs <- 1 - nvs
  }

  r[] <- nvs


  if(is.null(filename)){
    return(r)
  }

  writereadrast(
    r,
    filename,
    overwrite
  )
}
