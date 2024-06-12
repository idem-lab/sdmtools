#' @title set layer names
#' @description
#' Convenience function for setting `SpatRaster` layer names, enables setting in
#' piped workflows.
#'
#'
#' @param x `SpatRaster`
#' @param layernames `character` of length `nlyr(x)`
#'
#' @return `SpatRaster`
#' @export
#'
#' @examples
#' example_raster() |>
#'  set_layer_names("Charlie Watts")
set_layer_names <- function(x, layernames){

  if(length(layernames) != terra::nlyr(x)){
    stop("length(layernames) != terra::nlyr(x)")
  }

  names(x) <- layernames

  x
}
