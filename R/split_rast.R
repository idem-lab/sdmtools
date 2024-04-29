split_rast <- function(
    x,
    grain = 4,
    write_temp = TRUE
){

  dimx <- dim(x)[1]
  dimy <- dim(x)[2]

  resx <- res(x)[1]
  resy <- res(x)[2]

  xminx <- xmin(x)
  yminx <- ymin(x)

  xseq <- seq(
    from = 1,
    to = dimx,
    length.out = grain + 1
  ) |>
    round()

  yseq <- seq(
    from = 1,
    to = dimy,
    length.out = grain + 1
  ) |>
    round()

  xminseq <- xseq[1:grain]
  xmaxseq <- xseq[2:(grain + 1)]
  xmaxseq[1:(grain - 1)] <- xmaxseq[1:(grain - 1)] - 1

  yminseq <- yseq[1:grain]
  ymaxseq <- yseq[2:(grain + 1)]
  ymaxseq[1:(grain - 1)] <- ymaxseq[1:(grain - 1)] - 1

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
      across(starts_with("y"), ~ (.x - 1)*resy + yminx)
    ) |>
    mutate(
      r = pmap(
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
    pull(r)

}
