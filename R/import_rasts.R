#' @title Import rasters from directory
#' @description
#' Imports all rasters of a given extension type from a specified directory using `terra::rast`.
#' Based on `seegSDM::importRasters`.
#'
#'
#'
#' @param path Directory path containing rasters
#' @param ext Extension type
#' @param as_list Should the `spatRaster` objects be returned as a `list` (`TRUE`) or concatenated as layers in a single `spatRaster` object (`FALSE`; default)
#'
#' @return A `SpatRaster` if `as_list = FALSE`, or list of `SpatRaster` objects.
#' @export
#'
#' @examples
#' \dontrun{
#'   rasters <- import_rasts("/data/grids/covariates")
#' }
import_rasts <- function (path, ext = ".grd", as_list = c(FALSE, TRUE))
{
  files <- gtools::mixedsort(list.files(path, pattern = ext))

  rasts <- lapply(paste(path, files, sep = "/"), terra::rast)

  if(as_list){
    return(rasts)
  }

  do.call(c, rasts)

}
