#' @title Extract data from covariate rasters
#' @description
#' Extracts data from raster covariate layers for modelling.
#'
#'
#' @param covariates `SpatRaster` object of one or more layers.
#' @param presences `data.frame` or `tibble` of presence locations contaning longitude and latitude as variables `x` and `y`.
#' @param absences `data.frame` or `tibble` of absence or background locations contaning longitude and latitude as variables `x` and `y`.
#' @param presences_and_absences `data.frame` or `tibble` of presence presence and absence locations contaning longitude and latitude as variables `x` and `y`.
#'
#' @return A `tibble` containing values variables `presence` and each of the covarite layers at each location.
#' @author Gerry Ryan
#' @export
#'
#' @examples
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
    avals <- terra::extract(
      covariates,
      absences %>%
        dplyr::select(x, y)
    )

    result <- rbind(
      pvals %>%
        tibble::as_tibble %>%
        dplyr::select(-ID) %>%
        dplyr::mutate(presence = 1),
      avals %>%
        tibble::as_tibble %>%
        dplyr::select(-ID) %>%
        dplyr::mutate(presence = 0)
    ) %>%
      tibble::as_tibble

    return(result)
  } else {
    vals <- terra::extract(
      covariates,
      pa_data %>%
        dplyr::select(x, y)
    )

    result <- cbind(
      pa_data %>%
        dplyr::select(-x, -y),
      vals %>%
        tibble::as_tibble %>%
        dplyr::select(-ID)
    ) %>%
      tibble::as_tibble

    return(result)
  }
}
