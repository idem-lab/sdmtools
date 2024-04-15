library(tibble)

# equivalent functions (or near equivalent) from raster and terra
# search also "New method names" section in https://cran.r-project.org/web/packages/terra/terra.pdf
# arguments names may differ
# some notable changes to arguments, return values, etc
# are in the comment column
raster_to_terra <- tibble::tribble(
  ~raster,             ~terra, ~comment,
         "raster, brick, stack",                "rast", NA, # elevated due to primacy
                "rasterFromXYZ",  "rast(, type='xyz')", "note arg `type = xyz`",
              "stack, addLayer",                   "c", NA,
                     "addLayer",               "add<-", NA,
                         "area", "cellSize or expanse", NA,
                     "approxNA",         "approximate", NA,
                         "calc",                 "app", "think apply family, i.e., app(x, fun...)",
"cellFromLine, cellFromPolygon",               "cells", NA,
              "cellsFromExtent",               "cells", NA,
                    "cellStats",              "global", "global returns df not vector",
                        "clump",             "patches", NA,
                "compareRaster",         "compareGeom", NA,
                     "corLocal",          "focalPairs", NA,
                  "coordinates",                "crds", NA,
                "couldBeLonLat",           "is.lonlat", NA,
                         "crop",                "crop", NA,
                 "disaggregate",              "disagg", NA,
           "distanceFromPoints",            "distance", NA,
                   "drawExtent",                "draw", NA,
                    "dropLayer",              "subset", NA,
                       "extent",                 "ext", NA,
                      "extract",             "extract", "cellnumbers in raster becomes cells in terra\nbuffer argument not replaced, use st_buffer in a prior step?",
                    "getValues",              "values", "as.vector an alternative approach",
     "isLonLat, isGlobalLonLat",           "is.lonlat", NA,
                     "layerize",           "segregate", NA,
                   "layerStats",            "layerCor", NA,
                    "movingFun",                "roll", NA,
                      "NAvalue",              "NAflag", NA,
                      "nlayers",                "nlyr", NA,
                      "overlay",                "lapp", NA,
                "projectRaster",             "project", NA,
                         "plot",                "plot", "maxpixels in raster becomes maxcells in terra",
               "rasterToPoints",           "as.points", NA,
             "rasterToPolygons",         "as.polygons", NA,
        "reclassify, subs, cut",            "classify", NA,
                     "resample",            "resample", NA,
  "sampleRandom, sampleRegular",          "spatSample", NA,
                    "shapefile",                "vect", NA,
                   "stackApply",                "tapp", NA,
                  "stackSelect",         "selectRange", NA,
                      "unstack",             "as.list", NA,
                  "writeRaster",         "writeRaster", "need to specify file type (suffix) in terra",
) |>
  new_long_tibble() # set class to long_tibble

# run this line each time I update the thing.
usethis::use_data(raster_to_terra, overwrite = TRUE)
