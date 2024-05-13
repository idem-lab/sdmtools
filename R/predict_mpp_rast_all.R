#' @title Raster predictions from `multispeciesPP` for all species
#' @description
#' Calls `sdmtools::predict_mpp_rast` over all species in `model`
#'
#'
#' @param model A `multispeciesPP` model object
#' @param data `SpatRaster` object with covariate and bias layers
#' @param type `character`. Prediction scale — `"response"` or `"link"`.
#'
#' @return `SpatRaster`
#'
#' @export
#'
#' @examples
predict_mpp_rast_all <-  function(
    model,
    data,
    type = c("response", "link")
){

  spp <- colnames(model$species.coef)

  lapply(
    spp,
    FUN = function(x, model, data, type){
      sdmtools::predict_mpp_rast(
        model = model,
        data = data,
        sp = x,
        type = type
      )
    },
    model = model,
    data = data,
    type = type
  ) |>
    terra::rast()

}

