#' @title Extract covariates for presence only data
#' @description
#' Extracts
#'
#'
#' @param presences
#' @param absences
#' @param covariates
#'
#' @return
#' @export
#'
#' @examples
#'
extract_covariates <- function(
    presences,
    absences,
    covariates
){

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

  rbind(
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

}
