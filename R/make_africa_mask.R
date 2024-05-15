#' @title Make Africa Mask
#' @description
#' Makes a `SpatRaster` or `SpatVector` mask layer of Africa, based on shapefiles for African nations from the `malaraAtlas` package.
#'
#'
#' @param file_name Character of file path and name if  mask is to be written to disc.
#' @param type Character `raster` or `vector`; to return mask as either `SpatRaster` or `SpatVector`.
#' @param res Character `"high"` or `"low"`; corresponding to resolution of 0.008333333 or 0.04166667 decimal degrees
#' @param countries Character of ISO3 country names. If `NULL` returns all countries in Africa.
#'
#' @return `SpatRaster` or `SpatVector` in WGS 84 (EPSG:4326).
#' @export
#'
#' @details
#' Raster layers creates with extent of `terra::ext(-18.0000019073486, 52.0416647593181, -34.9999987284343, 37.5416679382324)`
#'
#' @examples
#' \dontrun{
#' # Create an object in workspace
#' africa_mask_v <- make_africa_mask(type = "vector")
#'
#' # Save to disk
#' make_africa_mask(file_name = "africa_mask.tif", type = "raster")
#'
#' # or do both at once
#' africa_mask_r <- make_africa_mask("africa_mask.tif")
#' }
make_africa_mask <- function(
    file_name = NULL,
    type = c("raster", "vector"),
    res = c("high", "low"),
    countries = NULL
  ){

  if(!is.null(file_name)){
    if(file.exists(file_name)){

      warning(sprintf(
        "%s exists\nUsing existing file\nto re-generate, delete existing %s",
        file_name,
        file_name
      ))

      if(type == "raster") {
        return(terra::rast(file_name))
      } else if(type == "vector"){
        return(terra::vect(file_name))
      }


    }
  }

  type <- match.arg(type)

  # get list of African countries
  if(is.null(countries)){
    countries <- sdmtools::global_regions %>%
      dplyr::filter(continent == "Africa") %>%
      dplyr::pull(iso3)
  }

  # make using MAP data
  # has issue with validity, st_make_valid 'fixes' this however...?
  #library(sf)
  #library(malariaAtlas)

  afvect <- malariaAtlas::getShp(
    ISO = countries
  ) |>
    sf::st_make_valid() |>
    sf::st_union() |>
    terra::vect() |>
    terra::fillHoles()

  if(type == "vector"){

    if(!is.null(file_name)){
      terra::writeVector(
        x = afvect,
        filename = file_name
      )

      afvect <- terra::vect(file_name)
    }

    return(afvect)
  }

  res <- match.arg(res)
  if(res == "high"){

    afrast <- terra::rast(
      nlyrs=1,
      crs = terra::crs("EPSG:4326"),
      #extent = ext(-25.3583333333333, 63.5, -40.3666666666667, 37.5416666666667),
      extent = terra::ext(-18.0000019073486, 52.0416647593181, -34.9999987284343, 37.5416679382324), # extent based on malariaAtlas::getRaster("Explorer__2020_Africa_ITN_Use")
      resolution = c(0.008333333, 0.008333333),
      vals = 1,
      names = "mask"
    ) |>
      terra::mask(afvect)

  } else if (res == "low"){
    afrast <- terra::rast(
      nlyrs=1,
      crs = terra::crs("EPSG:4326"),
      #extent = ext(-25.3583333333333, 63.5, -40.3666666666667, 37.5416666666667),
      extent = terra::ext(-18.0000019073486, 52.0416647593181, -34.9999987284343, 37.5416679382324),
      resolution = c(0.04166667, 0.04166667),
      vals = 1,
      names = "mask"
    ) |>
      terra::mask(afvect)
  }

  if(!is.null(file_name)){
    terra::writeRaster(
      x = afrast,
      filename = file_name,
      overwrite = TRUE
    )

    afrast <- terra::rast(file_name)
  }

  gc()

  afrast

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
