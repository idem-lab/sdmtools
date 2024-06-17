#' @title Standardise raster
#' @description Standardises all layers in a `SpatRaster` to a scale of 0-1,
#' by dividing by the maximum value in each layer.
#'
#' @param x `SpatRaster` to standardise
#' @param filename Optional `character` path and filename to write output
#' @param overwrite `logical` if `TRUE` will overwrite `filename`
#'
#' @return
#' @export
#'
#' @details
#' Will break for non-numeric rasters
#'
#'
#' @examples
#' example_raster() |>
#'   std_rast()
std_rast <- function(x, filename = NULL, overwrite = TRUE){
  if(terra::nlyr(x)>1){

    vals <- terra::values(x)

    nvs <- apply(
      vals,
      MARGIN = 2,
      FUN = function(x){
        x/max(x, na.rm = TRUE)
      }
    )

    r <- x

    r[] <- nvs


  } else {
    r <- x / max(x)
  }

  if(is.null(filename)){
    return(r)
  }

  writereadrast(
    r,
    filename,
    overwrite
  )
}
