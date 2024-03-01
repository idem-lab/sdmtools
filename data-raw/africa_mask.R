library(dplyr)
library(sdmtools)
library(terra)
library(geodata)

african_countries <- global_regions %>%
  dplyr::filter(un_region == "African states") %>%
  dplyr::pull(iso3)


africa_polys <- gadm(
  country = african_countries,
  path = "data-raw/geodata",
  level = 0,
  resolution = 1
)

library(sf)
aps_sf <- st_as_sf(africa_polys)

ap <- st_union(aps_sf)

africa_spatVec


# library(sf)
# library(malariaAtlas)
# trying to use MAP data, notworkign.
# allpoly <- malariaAtlas::getShp(
#   ISO = african_countries
# )
#
# africa_sf <- sf::st_union(allpoly[50:54,])
#
# sf::sf_use_s2(FALSE)
# somken <- malariaAtlas::getShp(ISO = c("SOM", "KEN"))
# sf::sf_use_s2(FALSE)
# sf::st_union(somken)
#
#
# someth <- malariaAtlas::getShp(ISO = c("SOM", "ETH"))
#
# sf::st_union(someth)
