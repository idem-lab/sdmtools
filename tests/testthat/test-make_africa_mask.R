testthat::test_that(
  "is SpatVector",
  {

    library(terra)

    mv <- make_africa_mask(
      type = "vector",
      countries = "NGA"
    )

    testthat::expect_s4_class(mv, "SpatVector")
  }
)

testthat::test_that(
  "low is SpatRaster",
  {
    library(terra)
    ml <- make_africa_mask(
      type = "raster",
      res = "low",
      countries = "UGA"
    )

    testthat::expect_s4_class(ml, "SpatRaster")

    testthat::expect_equal(terra::res(ml), c(0.04166667, 0.04166667))

  }
)

testthat::test_that(
  "high is SpatRaster",
  {
    library(terra)
    mh <- make_africa_mask(
      type = "raster",
      res = "high",
      countries = "MOZ"
    )

    testthat::expect_s4_class(mh, "SpatRaster")

    testthat::expect_equal(terra::res(mh), c(0.008333333, 0.008333333))
  }
)
