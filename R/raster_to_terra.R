#' @title `raster` to `terra` equivalence table
#' @description
#' A table of equivalent functions (or near equivalent) from the `raster` and `terra` packages.
#' @name raster_to_terra
#'
#' @format ## `global_regions`
#' A tibble with 42 rows and 3 columns:
#' \describe{
#'   \item{raster}{function name in `raster`}
#'   \item{terra}{function name in `terra`}
#'   \item{comment}{Annotations about differences in arguments or usage, etc.}
#' }
#'
#' @source Initially produced by Gerry Ryan and supplemented with "New method names" section in https://cran.r-project.org/web/packages/terra/terra.pdf, annotations added by IDEM members
#' @details
#' Some argument names may differ.
#'

"raster_to_terra"
