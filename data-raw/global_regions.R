library(dplyr)
library(readr)
library(stringr)
library(countrycode)


iso_countries <- read_csv(
  file = "data-raw/tabular/iso3166_countries.csv",
  na = c("") # otherwise mucks up Namibia iso2 NA
)


who <- read_csv(
  file = "data-raw/tabular/who-regions.csv",
  col_names = c("country", "iso3", "year", "who_region"),
  skip = 1
) |>
  select(-year)


un <- read_csv("data-raw/tabular/un-regions.csv") |>
  mutate(
    country = str_trim(country), # remove trailing whitespace
    iso3 = countrycode::countrycode(
      country,
      origin = "country.name",
      destination = "iso3c"
    )
  ) |>
  filter(!(iso3 == "TUR" & UN_regional_group == "Asia-Pacific States")) # remove duplicate of Turkiye and leave only in Western Europe and other states grouping as this is where they are a voting member

global_regions <- full_join(
  x = who,
  y = un,
  by = "iso3"
) |>
  full_join(
    y = iso_countries,
    by = "iso3"
  ) |>
  mutate(
    country = countrycode::countrycode(
      iso3,
      origin = "iso3c",
      destination = "country.name"
    ),
    un_region = UN_regional_group
  ) |>
  left_join(
    countrycode::codelist,
    by = join_by(iso3 == iso3c)
  ) |>
  dplyr::select(country, iso2, iso3, who_region, un_region, continent) |>
  dplyr::arrange(country) |>
  new_long_tibble() # set class to long_tibble

# run this line each time I update the thing.
usethis::use_data(global_regions, overwrite = TRUE)

