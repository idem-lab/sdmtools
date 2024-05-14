testthat::test_that("is a SpatRaster", {

  library(terra)
  library(sdmtools)

  r <- c(
   sdmtools::example_raster(seed = 1),
   sdmtools::example_raster(seed = 2),
   sdmtools::example_raster(seed = 3)
  )
  rvals <- terra::values(r)
  nas <- c(1:10, 105:120, 215:240)
  rvals[nas] <- NA
  r[] <- rvals
  s <- sdmtools::mask_all(rasts = r)

  testthat::expect_s4_class(s, "SpatRaster")

  testthat::expect_equal(dim(r), dim(s))

  svals <- terra::values(s)

  z <- apply(svals, c(1, 2), is.na)

  z1 <- z[,1]

  x <- apply(z, 2, FUN = function(x, y){ifelse(y, x, !x)}, y = z1)

  testthat::expect_true(all(x))

})
