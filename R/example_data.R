#' Create example raster for use in examples
#'
#' @return A `SpatRaster`.
#' @param seed A seed to pass to `set.seed(seed)`
#' @param layername `character` for layer name passed to `names`
#' @export
#'
#' @examples
#' example_raster()
#'
#' example_raster(
#'   seed = 3.142,
#'   layername = "jabberwock_density"
#' )
example_raster <- function(
    seed = NULL,
    layername = NULL
  ){

  if(is.null(seed)){
    set.seed(2024-01-22-1330)
  } else{
    set.seed(seed)
  }

  raster_log_norm <- matrix(
  data = rlnorm(100),
  nrow = 10,
  ncol = 10
) %>%
  terra::rast() %>%
  setNames("example")


  if(!is.null(layername)){
    names(raster_log_norm) <- layername
  }

  raster_log_norm
}

#' Create an example vector
#'
#' @return A `SpatVector`
#' @param seed A seed to pass to `set.seed(seed)`
#' @export
#'
#' @examples
#' example_vector()
example_vector <- function(seed = NULL){

  if(is.null(seed)){
    set.seed(2024-01-22-1331)
  } else{
    set.seed(seed)
  }

  vector_unif <- matrix(
    data = runif(20, 0, 10),
    nrow = 10) %>%
    terra::vect(type = "points")

  vector_unif

}
