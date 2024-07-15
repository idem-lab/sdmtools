#' @title set levels
#' @description
#' Convenience function for setting `SpatRaster` levels names to enable setting in
#' piped workflows.
#'
#'
#' @param x `SpatRaster`
#' @param levs `data.frame`
#'
#' @return `SpatRaster`
#' @export
#'
#' @examples
#' \dontrun{
#' categorical_raster |>
#'  set_levels(
#'   levs = tribble(
#'     ~value, ~category,
#'     30, "URBAN CENTRE",
#'     23, "DENSE URBAN CLUSTER",
#'     22, "SEMI-DENSE URBAN CLUSTER",
#'     21, "SUBURBAN OR PERI-URBAN",
#'     13, "RURAL CLUSTER",
#'     12, "LOW DENSITY RURAL",
#'     11, "VERY LOW DENSITY RURAL",
#'     10, "WATER"
#'    )
#'   ) %>%
#'     as.data.frame()
#' }
#'
set_levels <- function(x, levs){

  levels(x) <- levs

  x
}
