#' @title Write and read back `spatRaster`
#' @description When a new `terra::spatRaster` is created it is stored in
#' memory. Writing it to disc and reading the object back from file requires two
#' steps: `terra::writeRaster` then reading and re-assigning via `terra::rast`.
#' `writereadrast` wraps these into a single step.
#'
#' @param x A `terra::spatRaster`
#' @param filename A `character` file path and name to save `x` to disc.
#'
#' @return A `terra::spatRaster` object reading from disc at `filename`.
#' @export
#'
#' @examples
#' \dontrun{
#' # create raster then assign
#' r <- sdmtools::example_raster()
#' r <- writereadrast(r, "tootgarook.tif")
#'
#' # or roll into single step with pipe
#' q <- sdmtools::example_raster() |>
#'   writereadrast("frankstonfreeway.tif")
#' }
writereadrast <- function(x, filename){

  terra::writeRaster(
    x = x,
    filename = filename,
    overwrite = TRUE
  )

  terra::rast(x = filename)

}
