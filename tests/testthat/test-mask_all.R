testthat::test_that("is a SpatRaster", {

  library(terra)
  library(sdmtools)

  r <- c(
   sdmtools::example_raster(seed = 1),
   sdmtools::example_raster(seed = 2),
   sdmtools::example_raster(seed = 3)
  )
  rvals <- terra::values(rasts)
  nas <- c(1:10, 105:120, 215:240)
  rvals[nas] <- NA
  r[] <- rvals
  s <- sdmtools::mask_all(rasts = r)

  testthat::expect_s4_class(s, "SpatRaster")

  testthat::expect_equal(dim(r), dim(s))
})
