#'@title Split rasters
#'@details Splits a `SpatRaster` up into a `grain^2` list of approximately equal
#'geographic sized rasters covering the extent of  `x`
#'
#'@param x A `SpatRaster`
#'@param grain Grain of splitting.
#'@param write_temp
#'
#'@return A list of `SpatRaster`s of length `grain^2`.
#'@export
#'
#' @examples
#'
#'# Split a raster into four
#' r <- example_raster()
#' s <- split_rast(r, grain = 2)
#' s
#'
#' # plot with original
#'  ps <- lapply(
#'    s,
#'    FUN = extend,
#'    y = r
#'  ) |>
#'    rast()
#'
#'  c(r, ps) |>  plot()
#'
split_rast <- function(
    x,
    grain = 4,
    write_temp = FALSE
){

  dimx <- dim(x)[1]
  dimy <- dim(x)[2]

  if(grain > dimx | grain > dimy){
    stop("grain is > x or y dimension.\nCannot split into rasters smaller than cells.")
  }

  resx <- terra::res(x)[1]
  resy <- terra::res(x)[2]

  xminx <- terra::xmin(x)
  yminx <- terra::ymin(x)

  xseq <- seq(
    from = 1,
    to = dimx + 1,
    length.out = grain + 1
  ) |>
    round()

  yseq <- seq(
    from = 1,
    to = dimy + 1,
    length.out = grain + 1
  ) |>
    round()

  xminseq <- xseq[1:grain]
  xmaxseq <- xseq[2:(grain + 1)]

  yminseq <- yseq[1:grain]
  ymaxseq <- yseq[2:(grain + 1)]

  tidyr::expand_grid(
    tibble::tibble(
      xmin = xminseq,
      xmax = xmaxseq
    ),
    tibble::tibble(
      ymin = yminseq,
      ymax = ymaxseq
    )
  ) |>
    dplyr::mutate(
      dplyr::across(starts_with("x"), ~ (.x - 1)*resx + xminx),
      dplyr::across(starts_with("y"), ~ (.x - 1)*resy + yminx)
    ) |>
    dplyr::mutate(
      r = purrr::pmap(
        .l = list(xmin, xmax, ymin, ymax, x, write_temp),
        .f = function(xmin, xmax, ymin, ymax, x, write_temp){

          xt <- terra::ext(c(xmin, xmax, ymin, ymax))

          z <- terra::crop(x, xt)

          if(write_temp){

            z <- sdmtools::writereadrast(z, tempfile(fileext = ".tif"))

          }

          z

        }
      )
    ) |>
    dplyr::pull(r)

}
