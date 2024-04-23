#' @title Make Africa Mask
#' @description
#' Makes a `spatRaster` mask layer of Africa, based on shapefiles for African nations from the `malaraAtlas` package. Function is a little slow, so writing to disc may be preferred.
#'
#'
#' @param file_name Character of file path and name if  mask is to be written to disc.
#' @param type Character `raster` or `vector`; to return mask as either `SpatRaster` or `SpatVector`.
#' @param res Character `"high"` or `"low"`; corresponding to resolution of 0.008333333 or 0.04166667 decimal degrees
#'
#' @return `SpatRaster` or `SpatVector` mask of Africa; WGS 84 (EPSG:4326).
#' @export
#'
#' @details
#' Created using countries where `sdmtools::global_regions$continent == "Africa"` and either the "Explorer__2020_Africa_ITN_Use" or  ""Explorer__2020_walking_only_travel_time_to_healthcare" raster from `malariaAtlas::getShp`
#'
#' @examples
#' # Create an object in workspace
#' africa_mask <- make_africa_mask()
#'
#' # Save to disk
#' make_africa_mask("africa_mask.tif")
#'
#' # or do both at once
#' africa_mask <- make_africa_mask("africa_mask.tif")
make_africa_mask <- function(
    file_name = NULL,
    type = c("raster", "vector"),
    res = c("high", "low")
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
  african_countries <- sdmtools::global_regions %>%
    dplyr::filter(continent == "Africa") %>%
    dplyr::pull(iso3)

  # make using MAP data
  # has issue with validity, st_make_valid 'fixes' this however...?
  #library(sf)
  #library(malariaAtlas)

  afvect <- malariaAtlas::getShp(
    ISO = african_countries
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
    layer <- "Explorer__2020_walking_only_travel_time_to_healthcare"  # 0.008333333
  } else if (res == "low"){
    layer <- "Explorer__2020_Africa_ITN_Use" # 0.04166667
  }


  afrast <- afvect |>
    st_as_sf() |>
    malariaAtlas::getRaster(
      dataset_id = layer,
      shp = _
    )

  afmask <- afrast
  afmask[which(!is.na(afmask[]))] <- 0

  terra::varnames(afmask) <- names(afmask) <- "mask"


  if(!is.null(file_name)){
    terra::writeRaster(
      x = afmask,
      filename = file_name,
      overwrite = TRUE
    )

    afmask <- rast(file_name)
  }

  gc()

  afmask



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
