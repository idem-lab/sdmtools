#' Title
#'
#' @param r
#' @param v
#' @param pch
#' @param cex
#'
#' @return
#' @export
#'
#' @examples
rastpointplot <- function(
    r,
    v,
    pch = 16,
    cex = 0.5
){

  plot(r)
  points(v, pch = pch, cex = cex)

}
