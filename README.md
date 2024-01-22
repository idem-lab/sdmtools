
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sdmtools

<!-- badges: start -->
[![Licence](https://img.shields.io/github/license/Ileriayo/markdown-badges?style=for-the-badge)](./LICENSE)
<hr>
<hr>
<!-- badges: end -->

`sdmtools` is a set of helper functions to facilitate species
distribution modelling.

## Installation

You can install the development version of sdmtools from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("geryan/sdmtools")
```

## Data

``` r
library(sdmtools)
```

`raster_to_terra` an annotated equivalence table of functions from the
`raster` and `terra` packages

``` r
raster_to_terra
#>           raster       terra
#> 1          brick           c
#> 2      cellStats      global
#> 3           crop        crop
#> 4   disaggregate      disagg
#> 5        extract     extract
#> 6      getValues   as.vector
#> 7           plot        plot
#> 8         raster        rast
#> 9  rasterFromXYZ        rast
#> 10      resample    resample
#> 11         stack           c
#> 12   writeRaster writeRaster
#>                                                   comment
#> 1                                                    <NA>
#> 2                            global returns df not vector
#> 3                                                    <NA>
#> 4                                                    <NA>
#> 5            cellnumbers in raster becomes cells in terra
#> 6                                                    <NA>
#> 7           maxpixels in raster becomes maxcells in terra
#> 8                                                    <NA>
#> 9  with arg `type = xyz`; where xyx is a string in quotes
#> 10                                                   <NA>
#> 11                                                   <NA>
#> 12            need to specify file type (suffix) in terra
```

`r` an example `spatRaster`

``` r
r
plot(r)
```

`v` an example `spatVector`

``` r
v
plot(v)
```

## Function examples

`source_R` — source all R files in a target directory

``` r
source_R(/Users/frankenstein/project/R)
```

`predict_sdm` — made a spatial prediction from a species distribution
model and covariate layers

``` r
m <- glm(z ~ cov1, cov2, data = sdm_data)

prediction <- predict_sdm(m, covs)
```

`import_rasts` — Import all rasters from a directory into a single
object

``` r
rasters <- import_rasts("/data/grids/covariates")
```

`rastpointplot` — plot a raster with points over it

``` r
rastpointplot(r,v)
```

`extract_covariates` — extract covariate values from `spatRaster` or
`raster` layers for a given set of points

``` r
# example
```
