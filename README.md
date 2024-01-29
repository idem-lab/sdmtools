
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
`raster` and `terra` packages incorporating section **XXVIII New method
names** from `terra`’s [package
notes](https://cran.r-project.org/web/packages/terra/terra.pdf)
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
<tr>
<td style="text-align:left;">
approxNA
</td>
<td style="text-align:left;">
approximate
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
calc
</td>
<td style="text-align:left;">
app
</td>
<td style="text-align:left;">
think apply family, i.e., app(x, fun…)
</td>
</tr>
<tr>
<td style="text-align:left;">
cellFromLine, cellFromPolygon
</td>
<td style="text-align:left;">
cells
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
cellsFromExtent
</td>
<td style="text-align:left;">
cells
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
clump
</td>
<td style="text-align:left;">
patches
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
compareRaster
</td>
<td style="text-align:left;">
compareGeom
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
corLocal
</td>
<td style="text-align:left;">
focalPairs
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
coordinates
</td>
<td style="text-align:left;">
crds
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
couldBeLonLat
</td>
<td style="text-align:left;">
is.lonlat
</td>
<td style="text-align:left;">
NA
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
distanceFromPoints
</td>
<td style="text-align:left;">
distance
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
drawExtent
</td>
<td style="text-align:left;">
draw
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
dropLayer
</td>
<td style="text-align:left;">
subset
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
extent
</td>
<td style="text-align:left;">
ext
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
values
</td>
<td style="text-align:left;">
as.vector an alternative approach
</td>
</tr>
<tr>
<td style="text-align:left;">
isLonLat, isGlobalLonLat
</td>
<td style="text-align:left;">
is.lonlat
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
layerize
</td>
<td style="text-align:left;">
segregate
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
layerStats
</td>
<td style="text-align:left;">
layerCor
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
movingFun
</td>
<td style="text-align:left;">
roll
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
NAvalue
</td>
<td style="text-align:left;">
NAflag
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
nlayers
</td>
<td style="text-align:left;">
nlyr
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
overlay
</td>
<td style="text-align:left;">
lapp
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
projectRaster
</td>
<td style="text-align:left;">
project
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
rasterToPoints
</td>
<td style="text-align:left;">
as.points
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
rasterToPolygons
</td>
<td style="text-align:left;">
as.polygons
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
reclassify, subs, cut
</td>
<td style="text-align:left;">
classify
</td>
<td style="text-align:left;">
NA
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
sampleRandom, sampleRegular
</td>
<td style="text-align:left;">
spatSample
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
shapefile
</td>
<td style="text-align:left;">
vect
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
stackApply
</td>
<td style="text-align:left;">
tapp
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
stackSelect
</td>
<td style="text-align:left;">
selectRange
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
unstack
</td>
<td style="text-align:left;">
as.list
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
