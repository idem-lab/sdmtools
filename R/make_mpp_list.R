#' @title Make presence-only list for `multispeciesPP`
#' @details The package `multispeciesPP` requires a very annoying named list
#'   format for presence-only data. This function takes a table of covariate /
#'   bias values and an ID column (i.e. species), and returns a named list where
#'   each element is the values corresponding to that identity only. Ugh.
#'
#'
#' @param x A `data.frame` containing covariate and bias values for locations,
#'   and an identity (species) column
#' @param id The name of the identity column in `tidyselect` form. `id` must be
#'   a column name in `x`.
#'
#' @return A named list or data frames.
#' @export
#'
#' @examples
#' \dontrun{
#' make_mpp_list(presence_only_data, species)
#' }
make_mpp_list <- function(x, id){

  y <- x %>%
    dplyr::group_by({{id}}) %>%
    dplyr::summarise(named_vec = list(.)) %>%
    tibble::deframe() |>
    lapply(dplyr::ungroup)

  mapply(
    function(name, tibble) {
      dplyr::filter(tibble, {{id}} == name) |>
        dplyr::select(-{{id}}) |>
        as.data.frame()
    },
    names(y),
    y,
    SIMPLIFY = FALSE
  )

}
