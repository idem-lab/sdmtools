#' Make a single-variable table and display it nicely in console
#'
#' @param x
#' @param usena per `?table`
#' @param n print how many rows eh?
#'
#' @returns
#' @export
#'
#' @examples
tabble <- function(
    x,
    usena = c("always", "no", "ifany"),
    n = 50
  ){

  usena <- match.arg(usena)

  table(x, useNA = usena) |>
    as.data.frame() |>
    as_tibble() |>
    print(n = n)

}
