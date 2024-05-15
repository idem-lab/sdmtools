#' Title
#'
#' @param df data.frame
#' @param msk mask
#'
#' @return tibble of two columsn, lon and lat
#' @export
#'
#' @examples
maskpointsdf <- function(df, msk){

  vctraw <- terra::vect(
    x = df,
    crs = "+proj=longlat +datum=WGS84"
  )

  pol <- terra::as.polygons(msk)

  vct <- terra::mask(vctraw, pol)

  terra::geom(vct) %>%
    as_tibble() %>%
    select(
      lon = x,
      lat = y
    )

}
# make crs a param
# document etc
# is this too niche? Naaaaaaaaaaah
