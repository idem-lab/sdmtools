#' Title
#'
#' @param pa_data
#' @param covariates
#'
#' @return
#' @export
#'
#' @examples
model_data_presence_absence <- function(
    pa_data,
    covariates
){

  vals <- terra::extract(
    covariates,
    pa_data %>%
      dplyr::select(x, y)
  )

  cbind(
    pa_data %>%
      dplyr::select(-x, -y),
    vals %>%
      tibble::as_tibble %>%
      dplyr::select(-ID)
  ) %>%
    tibble::as_tibble

}
