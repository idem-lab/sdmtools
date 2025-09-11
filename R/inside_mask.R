#' @title inside mask
#' @description  Checks whether longitude and latitude coincide with
#' non-missing pixels of a raster. The function takes two arguments:
#' points, a dataframe containing at a minimum columns representing
#' longitude' and 'latitude' (but could include other attributes),
#' and mask is a raster. Returns a dataframe of the same dimensions as the
#' input object, containing only those rows with points falling on
#' non-missing pixels. If all points fall on missing pixels,
#' the function throws an error.
#'
#' @param points dataframe containing columns named 'longitude' and 'latitude'
#' @param mask a raster
#'
#' @return dataframe of longitude and latitude only those rows with
#'   points falling on non-missing pixels. If all points fall on missing
#'   pixels, the function throws an error.
#' @export
#'
#' @examples
inside_mask <- function(
  points,
  mask,
  var_names = c("longitude", "latitude"),
  inside = TRUE
) {
  # check whether arguments are in the correct format
  stopifnot(
    "mask must be a SpatRaster" = inherits(mask, 'SpatRaster')
  )

  stopifnot(
    "points object must be a data.frame." = inherits(points, 'data.frame')
  )

  if (sum(colnames(points) %in% c("longitude", "latitude")) != 2) {
    points <- points %>%
      rename(
        longitude = var_names[[1]],
        latitude = var_names[[2]]
      )
  }

  stopifnot(
    "var_names for longitude and latitude from points data.frame must be numeric" = sum(
      colnames(points) %in% c("longitude", "latitude")
    ) ==
      2
  )

  # get indexes of points which fall inside the mask
  inside_idx <- which(
    !(is.na(terra::extract(
      mask,
      points[, c('longitude', 'latitude')],
      ID = FALSE
    )))
  )

  # subset the points according to inside or outside criteria

  if (inside) {
    subset_points <- points[inside_idx, ]
  } else {
    subset_points <- points[!inside_idx, ]
  }

  # if raster values exist for one point or more, return the point/s,
  # otherwise throw an error
  if (nrow(points[inside_idx, ]) == 0) {
    stop('all points outside mask')
  }

  return(subset_points)
}
