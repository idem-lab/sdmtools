test_that("is a SpatRaster", {
  expect_s4_class(example_raster(), "SpatRaster")
})
