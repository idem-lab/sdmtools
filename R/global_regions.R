#'@title Global regions
#'@description A table of showing the United Nations Regional groups of Member
#'  States and World Health Organisation regions of nation states and all states
#'  with Officially Assigned ISO3166 Alpha-3 country codes.
#'@name global_regions
#'
#'@format ## `global_regions` A tibble with 249 rows and 6 columns:
#' \describe{
#'   \item{country}{Country name. Given name conflicts between the two data sources, names identified in `country` are defined as `countrycode::countrycode(global_regions$iso3, origin = "iso3c", destination = "country.name")`}
#'   \item{iso2, iso3}{Alpha-2 & Alpha-3 ISO3166 country codes}
#'   \item{who_region}{World Health Organisation region}
#'   \item{un_region}{United Nations Regional group of Member States}
#'   \item{continent}{Continent}
#' }
#'
#'@source Table combined from `un-regions.csv`, and `who-regions.csv`, housed in
#'  package data-raw directory.
#'
#'  `un-regions.csv` manually created from tables on "Regional groups of Member
#'  States"
#'
#'  \link{https://www.un.org/dgacm/en/content/regional-groups}
#'
#'  2024-02-02
#'
#'  `who-regions.csv` was downloaded from
#'
#'  \link{https://ourworldindata.org/grapher/who-regions}
#'
#'  2024-02-02
#'
#'  World Health Organization – processed by Our World in Data. “WHO region”
#'  [dataset]. World Health Organization [original data].
#'
#'
#'  `continent` defined by `countrycode::codelist$continent`, (largely?) by
#'  World Bank.
#'
#'
#'@details
#'
#'Includes all Officially Assigned ISO3166 Alpha-3 country codes.
#'
#'Not all 'countries' include a continent.
#'
#'Special cases of UN regional groupings
#'
#'Israel
#'
#'In May 2000, Israel became a full member of the Group of Western European and
#'other States on a temporary basis (subject to renewal), thereby enabling it to
#'put forward candidates for election to various bodies of the General Assembly.
#'In 2004, Israel obtained a permanent renewal to its membership.
#'
#'Kiribati
#'
#'As of 2010, Kiribati (geographically in Oceania) is not a member of any
#'regional group, despite other Oceania nations belonging to the Group of
#'Asia-Pacific States.
#'
#'Türkiye
#'
#'Türkiye participates fully in both the Group of Western European and other
#'States and the Group of Asia-Pacific States, but for electoral purposes is
#'considered a member of the Group of Western European and other States only.
#'
#'While Türkiye is listed in both groupings in the original dataset; here we
#'remove the duplication and list it only where it is a voting member, i.e.,
#'Western European and other States
#'
#'United States of America
#'
#'The United States of America is not a member of any regional group, but
#'attends meetings of the Group of Western European and other States as an
#'observer and is considered to be a member of that group for electoral
#'purposes.
#'
#'

"global_regions"
