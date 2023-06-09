#' Title
#'
#' @param model
#' @param covariates
#' @param type
#' @param layer_name
#'
#' @return
#' @export
#'
#' @examples
sdm_predict <- function(
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
