library(tibble)

# equivalent functions (or near equivalent) from raster and terra
# arguments names may differ
# some notable changes to arguments, return values, etc
# are in the comment column
raster_to_terra <- tibble::tribble(
  ~raster,             ~terra, ~comment,
         "brick",           "c", NA,
     "cellStats",      "global", "global returns df not vector",
          "crop",        "crop", NA,
  "disaggregate",      "disagg", NA,
       "extract",     "extract", "cellnumbers in raster becomes cells in terra",
     "getValues",   "as.vector", NA,
          "plot",        "plot", "maxpixels in raster becomes maxcells in terra",
        "raster",        "rast", NA,
 "rasterFromXYZ",        "rast",  "with arg `type = xyz`; where xyx is a string in quotes",
      "resample",    "resample", NA,
         "stack",           "c", NA,
   "writeRaster", "writeRaster", "need to specify file type (suffix) in terra",
)

usethis::use_data(raster_to_terra, overwrite = TRUE)
