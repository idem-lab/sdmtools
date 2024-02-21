
#' @title Assign to nearest raster cell on mask
#' @description
#' Adapted from seegSDM.
#' Reposition observations to a location within mask if within a specified distance.
#' Useful for when coastal observations drop off jagged mask and similar
#'
#' @param dat_object
#' @param mask_object
#' @param max_distance
#' @param verbose
#'
#' @return modified data object minus observations not within specified maximum distance of mask
#' @export
#'
#' @examples
assign_nearest_land <- function(dat_object,
                                mask_object,
                                max_distance,
                                verbose=TRUE) {

  # ensure that data object is spatial data frame
  spat_dat <- st_as_sf(dat_object)

  # assert that mask is spatRaster

  # isolate coord info from spatial data frame
  data_coords <- st_coordinates(spat_dat)

  spat_dat <- spat_dat %>% mutate(
    longitude = data_coords[,1],
    latitude = data_coords[,2]
  ) %>%
    select(-geometry)

  # find points outside mask

  vals <- terra::extract(mask_object,
                         data_coords)

  outside_mask <- is.na(vals)

  if (any(outside_mask)) {
    # if there are any outside the mask...

    # try to find new coordinates for these
    new_coords <- nearest_land(
      spat_dat[outside_mask,],
      mask_object,
      max_distance
    )

    # replace those coordinates in occurrence
    spat_dat[outside_mask, c('longitude', 'latitude')] <- new_coords

    # how many of these are still not on land
    still_out <- is.na(new_coords[, 1])

    # tell the user
    if (verbose) {
      cat(paste(sum(outside_mask),
                'points were outside mask.\n',
                sum(!still_out),
                'points were moved to dry land, ',
                sum(still_out),
                'points were further than',
                max_distance,
                'decimal degrees out and have been removed.\n\n'))
    }

    # update outside_mask
    outside_mask[outside_mask] <- still_out

    # and remove still-missing points from occurrence and vals
    dat_object <- dat_object[!outside_mask, , drop = FALSE]
  }

}


