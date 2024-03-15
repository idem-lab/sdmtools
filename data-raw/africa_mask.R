library(dplyr)
library(sdmtools)
# library(terra)
# library(geodata)

african_countries <- global_regions %>%
  dplyr::filter(continent == "Africa") %>%
  dplyr::pull(iso3)


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
# ap <- st_union(aps_sf)
#
# africa_spatVec


library(sf)
library(malariaAtlas)

africa_polys <- malariaAtlas::getShp(
  ISO = african_countries
) %>%
  sf::st_make_valid()



africa_sf <- sf::st_union(africa_polys)


sf::sf_use_s2(FALSE)
somken <- malariaAtlas::getShp(ISO = c("SOM", "KEN"))
sf::sf_use_s2(FALSE)
sf::st_union(somken)


someth <- malariaAtlas::getShp(ISO = c("SOM", "ETH"))

sf::st_union(someth)
