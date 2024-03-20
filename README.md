
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sdmtools

<!-- badges: start -->

![GitHub
License](https://img.shields.io/github/license/idem-lab/sdmtools)
![Lifecycle:](https://img.shields.io/badge/lifecycle-experimental-orange.svg)\](<https://lifecycle.r-lib.org/articles/stages.html#experimental>)
<!-- badges: end -->

`sdmtools` — a set of helper functions to facilitate species
distribution modelling.

## Installation

You can install the development version of sdmtools from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("idem-lab/sdmtools")
```

## Data

``` r
library(sdmtools)
```

`raster_to_terra` — an annotated equivalence table of functions from the
`raster` and `terra`. First 5 lines:

<table>
<thead>
<tr>
<th style="text-align:left;">
raster
</th>
<th style="text-align:left;">
terra
</th>
<th style="text-align:left;">
comment for terra use
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
raster, brick, stack
</td>
<td style="text-align:left;">
rast
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
rasterFromXYZ
</td>
<td style="text-align:left;">
rast(, type=‘xyz’)
</td>
<td style="text-align:left;">
note arg `type = xyz`
</td>
</tr>
<tr>
<td style="text-align:left;">
stack, addLayer
</td>
<td style="text-align:left;">
c
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
addLayer
</td>
<td style="text-align:left;">
add\<-
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
area
</td>
<td style="text-align:left;">
cellSize or expanse
</td>
<td style="text-align:left;">
NA
</td>
</tr>
</tbody>
</table>

`global_regions` — a tibble showing the WHO region, UN region, and
continent for for 249 countries and country-like things. First 5 lines:

<table>
<thead>
<tr>
<th style="text-align:left;">
country
</th>
<th style="text-align:left;">
iso2
</th>
<th style="text-align:left;">
iso3
</th>
<th style="text-align:left;">
who_region
</th>
<th style="text-align:left;">
un_region
</th>
<th style="text-align:left;">
continent
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Afghanistan
</td>
<td style="text-align:left;">
AF
</td>
<td style="text-align:left;">
AFG
</td>
<td style="text-align:left;">
Eastern Mediterranean
</td>
<td style="text-align:left;">
Asia-Pacific States
</td>
<td style="text-align:left;">
Asia
</td>
</tr>
<tr>
<td style="text-align:left;">
Albania
</td>
<td style="text-align:left;">
AL
</td>
<td style="text-align:left;">
ALB
</td>
<td style="text-align:left;">
Europe
</td>
<td style="text-align:left;">
Eastern European States
</td>
<td style="text-align:left;">
Europe
</td>
</tr>
<tr>
<td style="text-align:left;">
Algeria
</td>
<td style="text-align:left;">
DZ
</td>
<td style="text-align:left;">
DZA
</td>
<td style="text-align:left;">
Africa
</td>
<td style="text-align:left;">
African states
</td>
<td style="text-align:left;">
Africa
</td>
</tr>
<tr>
<td style="text-align:left;">
American Samoa
</td>
<td style="text-align:left;">
AS
</td>
<td style="text-align:left;">
ASM
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
Oceania
</td>
</tr>
<tr>
<td style="text-align:left;">
Andorra
</td>
<td style="text-align:left;">
AD
</td>
<td style="text-align:left;">
AND
</td>
<td style="text-align:left;">
Europe
</td>
<td style="text-align:left;">
Western European and other States
</td>
<td style="text-align:left;">
Europe
</td>
</tr>
</tbody>
</table>

### Data-generating functions

The package `terra` is fiddly about storing its `spat...` objects in
packages, so we chose to generate example spatial data on demand using
functions, rather than storing it.

`example_raster` — an example `spatRaster`.

``` r
library(terra)
#> terra 1.7.71
r <- example_raster()
r
#> class       : SpatRaster 
#> dimensions  : 10, 10, 1  (nrow, ncol, nlyr)
#> resolution  : 1, 1  (x, y)
#> extent      : 0, 10, 0, 10  (xmin, xmax, ymin, ymax)
#> coord. ref. :  
#> source(s)   : memory
#> name        :   example 
#> min value   : 0.0627102 
#> max value   : 7.3352526
plot(r)
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

`example_vector` — an example `spatVector`.

``` r
library(terra)
v <- example_vector()
v
#>  class       : SpatVector 
#>  geometry    : points 
#>  dimensions  : 10, 0  (geometries, attributes)
#>  extent      : 0.2293562, 8.00672, 1.375653, 8.951683  (xmin, xmax, ymin, ymax)
#>  coord. ref. :
plot(v)
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

`make_africa_mask` — makes a mask layer of Africa based on shapefiles
from `malariaAtlas::getShp`

``` r
library(terra)
africa_mask <- make_africa_mask(res = "low")
#> Please Note: Because you did not provide a version, by default the version being used is 202206 (This is the most recent version of admin unit shape data. To see other version options use function listShpVersions)
#> although coordinates are longitude/latitude, st_union assumes that they are
#> planar
#> Warning: [crs<-] not all geometries were transferred, use svc for a geometry
#> collection
#> Checking if the following Surface-Year combinations are available to download:
#> 
#>     DATASET ID  YEAR
#>   - Explorer__2020_Africa_ITN_Use:  DEFAULT
#> 
#> Loading required package: sf
#> Linking to GEOS 3.11.0, GDAL 3.5.3, PROJ 9.1.0; sf_use_s2() is FALSE
#> <GMLEnvelope>
#> ....|-- lowerCorner: -40.3706 -25.3587 "2000-01-01T00:00:00"
#> ....|-- upperCorner: 37.5439 63.5002 "2019-01-01T00:00:00"
plot(africa_mask)
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />

## Function examples

`rastpointplot` — simple utility to plot a raster with points over it.

``` r
rastpointplot(r,v)
```

<img src="man/figures/README-unnamed-chunk-8-1.png" width="100%" />

`source_R` — source all R files in a target directory

``` r
source_R("/Users/frankenstein/project/R") # do not run
```

`import_rasts` — import all rasters from a directory into a single
object

``` r
rasters <- import_rasts("/data/grids/covariates") # do not run
```

### Functions for a species distribution modelling workflow

We have some covariate layers: `cov1` and `cov2`

``` r
library(terra)

cov1 <- example_raster(
  seed = -44,
  layername = "cov1"
)
cov2 <- example_raster(
  seed = 15.3,
  layername = "cov2"
)

covs <- c(cov1, cov2)

plot(covs)
```

<img src="man/figures/README-unnamed-chunk-9-1.png" width="100%" />

We have some presences and absences

``` r
presences <- example_vector(seed = 68) %>%
  as.data.frame(geom = "xy")
absences <- example_vector(seed = 9.6) %>%
  as.data.frame(geom = "xy")

presences
#>           x        y
#> 1  9.244899 5.033042
#> 2  6.612025 1.559797
#> 3  4.024099 8.750261
#> 4  6.370063 4.438317
#> 5  3.526324 6.598762
#> 6  7.476441 7.754586
#> 7  7.175489 8.123659
#> 8  1.935898 5.082858
#> 9  3.331217 7.974853
#> 10 1.365547 5.741829
```

`extract_covariates` — extract covariate values from `spatRaster` or
`raster` layers for a given set of points

Pass in either `presences` and `absences` as a `data.frame` or `tibble`
of with , or `presences_and_absences` as a single data frame points with
a presence or ID column(s)

``` r
sdm_data <- extract_covariates(
  covariates = covs,
  presences = presences,
  absences = absences
)
```

`predict_sdm` — made a spatial prediction from a species distribution
model and covariate layers

``` r
# first we make a simple model, using data from above
m <- glm(presence ~ cov1 + cov2, data = sdm_data)

prediction_rast <- predict_sdm(m, covs)

plot(prediction_rast)
```

<img src="man/figures/README-unnamed-chunk-12-1.png" width="100%" />
