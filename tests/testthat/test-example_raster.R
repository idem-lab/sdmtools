testthat::test_that("is a SpatRaster", {
  testthat::expect_s4_class(example_raster(), "SpatRaster")
})
