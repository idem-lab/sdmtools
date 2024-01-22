#' Create example raster for use in examples
#'
#' @return raster
#' @export
#'
#' @examples
#' example_raster
example_raster <- function(){
set.seed(2024-01-22-1330)
  raster_log_norm <- matrix(
  data = rlnorm(100),
  nrow = 10,
  ncol = 10
) %>%
  terra::rast() %>%
  setNames("example")

  raster_log_norm
}

#' Create an example vector
#'
#' @return vector
#' @export
#'
#' @examples
#' example_vector()
example_vector <- function(){
  set.seed(2024-01-22-1331)
  vector_unif <- matrix(
    data = runif(20, 0, 10),
    nrow = 10) %>%
    terra::vect(type = "points")

  vector_unif

}
