test_that(
  "is SpatVector",
  {
    library(terra)

    mv <- make_africa_mask(
      type = "vector",
      countries = "NGA"
    )

    expect_s4_class(mv, "SpatVector")
  }
)

test_that(
  "low is SpatRaster",
  {
    library(terra)
    ml <- make_africa_mask(
      type = "raster",
      res = "low",
      countries = "UGA"
    )

    expect_s4_class(ml, "SpatRaster")

    expect_equal(res(ml), c(0.04166667, 0.04166667))
  }
)

test_that(
  "high is SpatRaster",
  {
    library(terra)
    mh <- make_africa_mask(
      type = "raster",
      res = "high",
      countries = "MOZ"
    )

    expect_s4_class(mh, "SpatRaster")

    expect_equal(res(mh), c(0.008333333, 0.008333333))
  }
)
