testthat::test_that("mean is zero", {
  testthat::expect_equal(
    sdmtools::example_raster() |>
      standardise_rast() |>
      terra::values() |>
      mean(na.rm = TRUE),
    0
  )
})

testthat::test_that("standard deviation is one", {
  testthat::expect_equal(
    sdmtools::example_raster() |>
      standardise_rast() |>
      terra::values() |>
      sd(na.rm = TRUE),
    1
  )
})
