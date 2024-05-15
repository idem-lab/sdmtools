test_that("mean is zero", {
  expect_equal(
    example_raster() |>
      standardise_rast() |>
      terra::values() |>
      mean(na.rm = TRUE),
    0
  )
})

test_that("standard deviation is one", {
  expect_equal(
    example_raster() |>
      standardise_rast() |>
      terra::values() |>
      sd(na.rm = TRUE),
    1
  )
})
