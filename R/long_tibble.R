#' @title `long_tibble` constructor function
#'
#' @param x A `tbl_df` object.
#'
#' @return `long_tibble`.
#' @export
#'
new_long_tibble <- function(x){
  stopifnot(dplyr::is.tbl(x))
  structure(x, class = c("long_tibble", class(x)))

}

#' @title Print method for class `long_tibble`
#' @description
#' Prints data tables stored in `sdmtools` for their entire length*, but maintains other nice print features
#' of `tbl_df`, i.e., tibbles.
#'
#' @param x An object of class `long_tibble`.
#'
#' @export
#'
#' @examples
#' print(raster_to_terra)
#'
#' @details
#' *"entire length" — well really, up to
#' 999 lines, which none currently are.
#'
#'
print.long_tibble <- function(x){
  x |>
    tibble::as_tibble() |>
    print(n = 999)
}
