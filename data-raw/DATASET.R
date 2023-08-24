library(tibble)

# equivalent functions (or near equivalent)
# from raster and terra
#argument names may differ

raster_to_terra <- tibble::tribble(
  ~raster,             ~terra, ~comment,
         "brick",         "c", NA,
     "cellStats",    "global", "global returns df not vector",
          "crop",      "crop", NA,
  "disaggregate",    "disagg", NA,
       "extract",   "extract", "cellnumbers = cells",
     "getValues", "as.vector", NA,
        "raster",      "rast", NA,
      "resample",  "resample", NA,
         "stack",         "c", NA
)

usethis::use_data(raster_to_terra, overwrite = TRUE)
