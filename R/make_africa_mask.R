library(dplyr)
library(sdmtools)
library(terra)
# library(geodata)

african_countries <- global_regions %>%
  dplyr::filter(continent == "Africa") %>%
  dplyr::pull(iso3)



make_africa_mask

# make using MAP data
# has issue with validity, st_make_valid 'fixes' this however
#library(sf)
#library(malariaAtlas)




africa_polys <- malariaAtlas::getShp(
  ISO = african_countries
) %>%
  sf::st_make_valid()

africa_sf <- sf::st_union(africa_polys)

dummy <- getRaster(dataset_id = "Explorer__2020_walking_only_travel_time_to_healthcare", shp = africa_sf)

africa_mask <- dummy

africa_mask[which(!is.na(africa_mask[]))] <- 0

#plot(africa_mask)
writeRaster(
  x = africa_mask,
  filename = "data-raw/africa_mask.tif"
)

z <- rast("data-raw/")

# small example to illustrate issue with MAP shapefiles
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
