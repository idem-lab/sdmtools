#' @title Predict Species Distribution Model
#' @description
#' Produces raster prediction from SDM based on model and covariate layers.
#'
#'
#' @param model A model object.
#' @param covariates `spatRaster` covariate layers.
#' @param type Scale of prediction (response, model, etc.).
#' @param layer_name Name for predicted layer.
#'
#' @return `spatRaster` prediction from model
#' @export
#'
#' @examples
predict_sdm <- function(
    model,
    covariates,
    type = NULL,
    layer_name = "predicted_distribution"
){

  if(is.null(type)){
    if (inherits(model, "maxnet")) {
      type <- "logistic"
    } else {
      type <- "response"
    }
  }

  prediction <- predict(covariates, model, na.rm = TRUE, type = type)
  names(prediction) <- layer_name

  return(prediction)
}
