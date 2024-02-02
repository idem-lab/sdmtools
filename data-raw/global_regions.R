library(dplyr)
library(readr)
library(stringr)
library(countrycode)

who <- read_csv(
  file = "data-raw/tabular/who-regions.csv",
  col_names = c("country", "iso3", "year", "who_region"),
  skip = 1
) |>
  select(-year)


un <- read_csv("data-raw/tabular/un-regions.csv") |>
  mutate(
    country = str_trim(country), # remove trailing whitespace
    iso3 = countrycode(
      country,
      origin = "country.name",
      destination = "iso3c"
    )
  )

global_regions <- full_join(
  x = who,
  y = un,
  by = "iso3"
) |>
  mutate(
    country = countrycode(
      iso3,
      origin = "iso3c",
      destination = "country.name"
    ),
    iso2 = countrycode(
      iso3,
      origin = "iso3c",
      destination = "iso2c"
    ),
    un_region = UN_regional_group
  ) |>
  select(country, iso2, iso3, who_region, un_region) |>
  arrange(country) |>
  print(n = 200)

