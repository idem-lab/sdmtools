test_that("mean is zero", {
  expect_equal(
    example_rast() |>
      standardise_rast() |>
      values() |>
      mean(na.rm = TRUE),
    0
  )
})

test_that("standard deviation is one", {
  expect_equal(
    example_rast() |>
      standardise_rast() |>
      values() |>
      sd(na.rm = TRUE),
    1
  )
})
