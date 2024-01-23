
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sdmtools

<!-- badges: start -->

[![Licence](https://img.shields.io/github/license/Ileriayo/markdown-badges?style=for-the-badge)](./LICENSE)
<!-- badges: end -->

`sdmtools` is a set of helper functions to facilitate species
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

`raster_to_terra` an annotated equivalence table of functions from the
`raster` and `terra` packages
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
brick
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
cellStats
</td>
<td style="text-align:left;">
global
</td>
<td style="text-align:left;">
global returns df not vector
</td>
</tr>
<tr>
<td style="text-align:left;">
crop
</td>
<td style="text-align:left;">
crop
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
disaggregate
</td>
<td style="text-align:left;">
disagg
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
extract
</td>
<td style="text-align:left;">
extract
</td>
<td style="text-align:left;">
cellnumbers in raster becomes cells in terra
</td>
</tr>
<tr>
<td style="text-align:left;">
getValues
</td>
<td style="text-align:left;">
as.vector
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
plot
</td>
<td style="text-align:left;">
plot
</td>
<td style="text-align:left;">
maxpixels in raster becomes maxcells in terra
</td>
</tr>
<tr>
<td style="text-align:left;">
raster
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
rast
</td>
<td style="text-align:left;">
with arg `type = xyz`; where xyx is a string in quotes
</td>
</tr>
<tr>
<td style="text-align:left;">
resample
</td>
<td style="text-align:left;">
resample
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
stack
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
writeRaster
</td>
<td style="text-align:left;">
writeRaster
</td>
<td style="text-align:left;">
need to specify file type (suffix) in terra
</td>
</tr>
</tbody>
</table>

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
source_R("/Users/frankenstein/project/R")
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
