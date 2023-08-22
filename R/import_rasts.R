#' @title Import rasters from directory
#' @description
#' Imports all rasters of a given extension type from a specified directory using `terra::rast`.
#'
#'
#'
#' @param path Directory path containing rasters
#' @param ext Extension type
#' @param as_list Should the `spatRaster` objects be returned as a `list` (`TRUE`) or concatenated into a single `spatRaster` (`FALSE`)
#'
#' @return A `spatRaster` if `as_list = FALSE`, or list of `spatRaster` objects.
#' @export
#'
#' @examples
import_rasts <- function (path, ext = ".grd", as_list = c(FALSE, TRUE))
{
  files <- gtools::mixedsort(list.files(path, pattern = ext))

  rasts <- lapply(paste(path, files, sep = "/"), terra::rast)

  if(as_list){
    return(rasts)
  }

  do.call(c, rasts)

}
