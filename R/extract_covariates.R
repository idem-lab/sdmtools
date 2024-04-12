#'@title Extract data from covariate rasters
#'@description Extracts data from raster covariate layers for modelling.
#'
#'
#'@param covariates `SpatRaster` object of one or more layers.
#'@param presences `data.frame` or `tibble` of presence locations contaning
#'  longitude and latitude as variables `x` and `y`.
#'@param absences `data.frame` or `tibble` of absence or background locations
#'  contaning longitude and latitude as variables `x` and `y`.
#'@param presences_and_absences `data.frame` or `tibble` of presence presence
#'  and absence locations containing longitude and latitude as variables `x` and
#'  `y`.
#'
#'@return A `tibble` containing values variables `presence` and each of the
#'  covariate layers at each location.
#'@author Gerry Ryan
#'@export
#'
#'@details `extract_covariates` will run correctly with either `presences` only,
#'`presences` and `absences`, or `presences_and_absences` only. (If all three
#'are included it will ignore the last one).
#'
#'
#' @examples
#'
#'library(terra)
#'
#'cov1 <- example_raster(
#'  seed = -44,
#'  layername = "cov1"
#')
#'cov2 <- example_raster(
#'  seed = 15.3,
#'  layername = "cov2"
#')
#'
#'covs <- c(cov1, cov2)
#'
#'
#'presences <- example_vector(seed = 68) %>%
#'  as.data.frame(geom = "xy")
#'absences <- example_vector(seed = 9.6) %>%
#'  as.data.frame(geom = "xy")
#'
#'extract_covariates(
#'  covariates = covs,
#'  presences = presences,
#'  absences = absences
#')
#'
extract_covariates <- function(
    covariates,
    presences = NULL,
    absences = NULL,
    presences_and_absences = NULL
){

  if(!is.null(presences)){
    pvals <- terra::extract(
      covariates,
      presences %>%
        dplyr::select(x, y)
    )

    if(!is.null(absences)){
      avals <- terra::extract(
        covariates,
        absences %>%
          dplyr::select(x, y)
      )

      result <- rbind(
        pvals %>%
          tibble::as_tibble() %>%
          dplyr::select(-ID) %>%
          dplyr::mutate(presence = 1),
        avals %>%
          tibble::as_tibble() %>%
          dplyr::select(-ID) %>%
          dplyr::mutate(presence = 0)
      ) %>%
        tibble::as_tibble()

      return(result)
    } else{
      result <- pvals %>%
        tibble::as_tibble() %>%
        dplyr::select(-ID) %>%
        dplyr::mutate(presence = 1)

      return(result)
    }

  } else {
    pa_data <- presences_and_absences

    vals <- terra::extract(
      covariates,
      pa_data %>%
        dplyr::select(x, y)
    )

    result <- cbind(
      pa_data %>%
        dplyr::select(-x, -y),
      vals %>%
        tibble::as_tibble() %>%
        dplyr::select(-ID)
    ) %>%
      tibble::as_tibble()

    return(result)
  }
}
