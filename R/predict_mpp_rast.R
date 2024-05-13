#' @title Raster predictions from `multispeciesPP`
#' @description
#' Make spatial predictions from `multispeciesPP::predict.multispeciesPP` by passing in data as `terra::SpatRaster` layers and returning a `SpatRaster`.
#'
#'
#' @param model A `multispeciesPP` model object
#' @param data `SpatRaster` object with covariate and bias layers
#' @param sp `character` Species name to predict
#' @param type `character`. Prediction scale — `"response"` or `"link"`.
#'
#' @return `SpatRaster`
#' @export
#'
#' @examples
predict_mpp_rast <- function(
    model,
    data,
    sp,
    type = c("response", "link")
){

  type = match.arg(type)


  non_na_idx <- which(!is.na(as.vector(data[[1]])))

  pred_data <- data[non_na_idx]

  preds <- multispeciesPP::predict.multispeciesPP(
    object = model,
    newdata = pred_data,
    species = sp
  ) # these are on link scale

  if(type == "response"){
    preds <- 1 - exp(-exp(preds))
  }

  pred_rast <- data[[1]]

  names(pred_rast) <- sp

  pred_rast[non_na_idx] <- preds[, 1]


}
