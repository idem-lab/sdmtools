
#' @title title
#' @description
#' # checks whether lats/longs fall on non-missing pixels of a raster
# takes two arguments: points, a dataframe containing columns named 'longitude' and 'latitude'
# mask is a raster
# returns a dataframe containing only those rows with points falling on non-missing pixels
# if all points fall on missing pixels, the function throws an error
#'
#' @param points
#' @param raster
#'
#' @return
#' @export
#'
#' @examples
inside_mask <- function(points, mask){

    # check whether arguments are in the correct format
    stopifnot(inherits(mask, 'SpatRaster'))
  message("mask must be a SpatRaster")

    stopifnot(inherits(points, 'data.frame'))
  message("points object must be a data.frame with columns 'longitude' and 'latitude'.")

      stopifnot(sum(colnames(points) %in% c("longitude", "latitude"))==2)
  message("points object must contain columns 'longitude' and 'latitude'.")


    # get indexes of points which fall inside the mask
    inside_idx <- which(
      !(is.na(extract(mask, points[,c('longitude', 'latitude')], ID=FALSE)))
      )

    # subset these points
    inside_points <- points[inside_idx, ]

    # if raster values exist for one point or more, return the point/s,
    # otherwise throw an error
    if (nrow(inside_points)==0) {stop('all points outside mask')}

    return (inside_points)

  }
