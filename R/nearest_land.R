#' @title Identify nearest land
#' @description
#' Adapted from seegSDM
#' Identify closest neighbouring cell that does not return NA on raster mask
#'
#' @param points anything [terra::extract()] accepts as the y argument
#' @param raster raster
#' @param max_distance the map units if raster is projected
#'
#' @return matrix of XY coordinates of nearest cell on mask, or NAs
#' @export
#'
#' @examples
nearest_land <- function (points, raster, max_distance) {
  # get nearest non_na cells (within a maximum distance) to a set of points
  # points can be anything extract accepts as the y argument
  # max_distance is in the map units if raster is projected
  # or metres otherwise

  # function to find nearest of a set of neighbours or return NA
  nearest <- function (lis, raster) {
    neighbours <- lis[[1]] #$neighbours
    point <- lis[[2]] # $point
    # neighbours is a two column df giving cell values and numbers
    land <- !is.na(neighbours[, 1]) # is value NA?
    if (!any(land)) {
      # if there is no land, give up and return NA
      return (c(NA, NA))
    } else{
      # otherwise get the land cell coordinates
      coords <- xyFromCell(raster, neighbours[land, 2]) # get XY from cell num

      if (nrow(coords) == 1) {
        # if there's only one, return it
        return (coords[1, ])
      }

      # otherwise calculate distances
      dists <- sqrt((coords[, 1] - point[1]) ^ 2 +
                      (coords[, 2] - point[2]) ^ 2)

      # and return the coordinates of the closest
      return (coords[which.min(dists), ])
    }
  }

  buffer_points <- sf::st_buffer(
    sf::st_as_sf(points),  # redundant now
    max_distance
    )

  # extract cell numbers within max_distance of the points
  neighbour_list <- extract(
    raster,
    buffer_points,
    cells = TRUE
    )

  # add the original point in there too
  neighbour_list <- lapply(1:nrow(points),
                           function(i) {
                             list(
                               neighbours = neighbour_list[neighbour_list$ID==i, 2:3 ],
                               point = st_coordinates(points[i, ]) #c("X","Y")
                              )
                           })

  return (t(sapply(neighbour_list, nearest, raster)))
}
