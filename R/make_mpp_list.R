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
#' @return A named list.
#' @export
#'
#' @examples
#' \dontrun{
#' make_mpp_list(presence_only_data, species)
#' }
make_mpp_list <- function(x, id){

  y <- x %>%
    group_by({{id}}) %>%
    summarise(named_vec = list(.)) %>%
    deframe() |>
    lapply(ungroup)

  mapply(
    function(name, tibble) {
      filter(tibble, {{id}} == name) |>
        select(-{{id}})
    },
    names(y),
    y,
    SIMPLIFY = FALSE
  )

}
