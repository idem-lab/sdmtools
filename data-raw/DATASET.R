library(tibble)


raster_to_terra <- tibble::tribble(
  ~raster,             ~terra, ~comment,
         "brick",         "c", NA,
     "cellStats",    "global", NA,
          "crop",      "crop", NA,
  "disaggregate",    "disagg", NA,
       "extract",   "extract", NA,
     "getValues", "as.vector", NA,
        "raster",      "rast", NA,
      "resample",  "resample", NA,
         "stack",         "c", NA
)

usethis::use_data(raster_to_terra, overwrite = TRUE)
