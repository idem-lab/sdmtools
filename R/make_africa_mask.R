#' @title Make Africa Mask
#' @description
#' Makes a `spatRaster` mask layer of Africa, based on shapefiles for African nations from the `malaraAtlas` package. Function is a little slow, so writing to disc may be preferred.
#'
#'
#' @param file_name Character of file path and name if  mask is to be written to disc.
#' @param res Character `"high"` or `"low"`; correspondiing to resolution of 0.008333333 or 0.04166667 decimal degrees
#'
#' @return `spatRaster` mask of Africa; WGS 84 (EPSG:4326).
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
make_africa_mask <- function(file_name = NULL, res = c("high", "low")){

  if(file.exists(file_name)){

    warning(sprintf(
      "%s exists\nUsing existing file\nto re-generate, delete existing %s",
      file_name,
      file_name
    ))
    return(terra::rast(file_name))
  }

  res <- match.arg(res)
  if(res == "high"){
    layer <- "Explorer__2020_walking_only_travel_time_to_healthcare"  # 0.008333333
  } else if (res == "low"){
    layer <- "Explorer__2020_Africa_ITN_Use" # 0.04166667
  }

  # get list of African countries
  african_countries <- sdmtools::global_regions %>%
    dplyr::filter(continent == "Africa") %>%
    dplyr::pull(iso3)

  # make using MAP data
  # has issue with validity, st_make_valid 'fixes' this however...?
  #library(sf)
  #library(malariaAtlas)

  afrast <- malariaAtlas::getShp(
    ISO = african_countries
  ) |>
    sf::st_make_valid() |>
    sf::st_union() |>
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

}

