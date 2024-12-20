#' @title Make Mask
#' @description Makes a `SpatRaster` or `SpatVector` mask layer of countries,
#' based on shapefiles for from the `malaraAtlas` package.
#'
#'
#' @param filename Character of file path and name if  mask is to be written to
#'   disc.
#' @param type Character `raster` or `vector`; to return mask as either
#'   `SpatRaster` or `SpatVector`.
#' @param res Character `"high"` or `"low"`; corresponding to resolution of
#'   0.008333333 or 0.04166667 decimal degrees
#' @param countries Character of ISO3 country names. If `NULL` returns all
#'   countries in Africa.
#' @param overwrite logical
#'
#' @aliases make_africa_mask make_vector_mask
#'
#' @return `SpatRaster` or `SpatVector` in WGS 84 (EPSG:4326).
#' @export
#'
#' @details # standard usage make_mask(filename = NULL, type = c("raster",
#' "vector"), res = c("high", "low"), countries = NULL)
#'
#' `make_africa_mask` is intended for backward compatibility but is a simple
#' alias for `make_mask` make_africa_mask(filename = NULL, type = c("raster",
#' "vector"), res = c("high", "low"), countries = NULL)
#'
#' `make_vector_mask` sets `type = "vector"` make_mask(filename = NULL, res =
#' c("high", "low"), countries = NULL)
#' @examples
#' \dontrun{
#' # Create an object in workspace
#' africa_mask_v <- make_mask(type = "vector")
#'
#' # Save to disk
#' make_mask(filename = "africa_mask.tif", type = "raster")
#'
#' # or do both at once
#' africa_mask_r <- make_africa_mask("africa_mask.tif")
#' }
make_mask <- function(
    filename = NULL,
    type = c("raster", "vector"),
    res = c("high", "low"),
    countries = NULL,
    overwrite = FALSE
  ){

  if(!is.null(filename)){
    if(file.exists(filename) & !overwrite){

      warning(sprintf(
        "%s exists\nUsing existing file",
        filename,
        filename
      ))

      if(type == "raster") {
        return(terra::rast(filename))
      } else if(type == "vector"){
        return(terra::vect(filename))
      }


    }
  }

  if(is.null(countries)){
    # get list of African countries
    countries <- sdmtools::global_regions %>%
      dplyr::filter(continent == "Africa") %>%
      dplyr::pull(iso3)
  }

  type <- match.arg(type)

  # make using MAP data
  # has issue with validity, st_make_valid 'fixes' this however...?

  afvect <- malariaAtlas::getShp(
    ISO = countries
  ) |>
    sf::st_make_valid() |>
    sf::st_union() |>
    terra::vect() |>
    terra::fillHoles()

  if(type == "vector"){

    if(!is.null(filename)){
      terra::writeVector(
        x = afvect,
        filename = filename
      )

      afvect <- terra::vect(filename)
    }

    return(afvect)
  }

  res <- match.arg(res)

  resn <- ifelse(
    res == "high",
    0.008333333,
    0.04166667
  )

  xt <- terra::ext(afvect)

  afrast <- terra::rast(
    nlyrs=1,
    crs = terra::crs("EPSG:4326"),
    extent = xt,
    resolution = c(resn, resn),
    vals = 1,
    names = "mask"
  ) |>
    terra::mask(afvect)

  if(!is.null(filename)){
    terra::writeRaster(
      x = afrast,
      filename = filename,
      overwrite = TRUE
    )

    afrast <- terra::rast(filename)
  }

  gc()

  afrast

}


#' @export
make_africa_mask <- function(
    filename = NULL,
    type = c("raster", "vector"),
    res = c("high", "low"),
    countries = NULL
){

  make_mask(
    filename = filename,
    type = type,
    res = res,
    countries = countries
  )

}

#' @export
make_vector_mask <- function(
    filename = NULL,
    res = c("high", "low"),
    countries = NULL
){

  make_mask(
    filename = filename,
    type = "vector",
    res = res,
    countries = countries
  )

}



# small example to illustrate validity issue with MAP shapefiles
# sf::sf_use_s2(FALSE)
# somken <- malariaAtlas::getShp(ISO = c("SOM", "KEN"))
# sf::sf_use_s2(FALSE)
# sf::st_union(somken)
#
# someth <- malariaAtlas::getShp(ISO = c("SOM", "ETH"))
#
# sf::st_union(someth)

# using geodata
# africa_polys <- gadm(
#   country = african_countries,
#   path = "data-raw/geodata",
#   level = 0,
#   resolution = 1
# )
#
# library(sf)
# aps_sf <- st_as_sf(africa_polys)
#
# sf_use_s2(FALSE)
# ap <- st_union(aps_sf)
#
# africa_spatVec
