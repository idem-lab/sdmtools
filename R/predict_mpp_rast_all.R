#' @title Raster predictions from `multispeciesPP` for all species
#' @description
#' Calls `sdmtools::predict_mpp_rast` over all species in `model`
#'
#'
#' @param model A `multispeciesPP` model object
#' @param data `SpatRaster` object with covariate and bias layers
#' @param type `character`. Prediction scale — `"response"` or `"link"`.
#' @param filename `character`to save output
#' @param overwrite `logical` overwrite existing `filename`?
#'
#' @return `SpatRaster`
#'
#' @export
#'
#' @examples
predict_mpp_rast_all <-  function(
    model,
    data,
    type = c("response", "link"),
    filename = NULL,
    overwrite = FALSE
){

  type = match.arg(type)

  if(!is.null(filename)){
    if(file.exists(filename) & !overwrite){

      warning(sprintf(
        "%s exists\nUsing existing file\nto re-generate, delete existing %s or set overwrite = TRUE",
        filename,
        filename
      ))

      return(terra::rast(filename))

    }
  }

  spp <- colnames(model$species.coef)

  pred_rasts <- lapply(
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

  if(!is.null(filename)){
    pred_rasts <- sdmtools::writereadrast(
      x = pred_rasts,
      filename = filename,
      overwrite = overwrite
    )
  }

  pred_rasts

}

