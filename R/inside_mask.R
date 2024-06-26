
#' @title title
#' @description  Checks whether longitude and latitude coincide with
#' non-missing pixels of a raster. The function takes two arguments:
#' points, a dataframe containing columns named
#' longitude' and 'latitude', and mask is a raster. Returns a dataframe
#' of longitude and latitude only those rows with points falling on
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
inside_mask <- function(points, mask){

    # check whether arguments are in the correct format
    stopifnot(
      "mask must be a SpatRaster" = inherits(mask, 'SpatRaster')
      )

    stopifnot(
      "points object must be a data.frame." = inherits(points, 'data.frame')
      )

      stopifnot(
        "points data.frame must contain columns 'longitude' and 'latitude'." = sum(colnames(points) %in% c("longitude", "latitude"))==2
        )

    # get indexes of points which fall inside the mask
    inside_idx <- which(
      !(is.na(terra::extract(mask, points[,c('longitude', 'latitude')], ID=FALSE)))
      )

    # subset these points
    inside_points <- points[inside_idx, ]

    # if raster values exist for one point or more, return the point/s,
    # otherwise throw an error
    if (nrow(inside_points)==0) {stop('all points outside mask')}

    return (inside_points)

  }
