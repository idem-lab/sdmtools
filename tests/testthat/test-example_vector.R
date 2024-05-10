testthat::test_that("is a SpatVector", {
  testthat::expect_s4_class(example_vector(), "SpatVector")
})
