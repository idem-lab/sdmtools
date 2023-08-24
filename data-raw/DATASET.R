library(tibble)

# equivalent functions (or near equivalent) from raster and terra
# arguments names may differ
# some notable changes to arguments, return values, etc
# are in the comment column
raster_to_terra <- tibble::tribble(
  ~raster,             ~terra, ~comment,
         "brick",         "c", NA,
     "cellStats",    "global", "global returns df not vector",
          "crop",      "crop", NA,
  "disaggregate",    "disagg", NA,
       "extract",   "extract", "cellnumbers = cells",
     "getValues", "as.vector", NA,
          "plot",      "plot", "maxpixels = maxcells",
        "raster",      "rast", NA,
      "resample",  "resample", NA,
         "stack",         "c", NA
)

usethis::use_data(raster_to_terra, overwrite = TRUE)
