#' @title Write and read back `spatRaster`
#' @description When a new `terra::SpatRaster` is created it is stored in
#' memory. Writing it to disc and reading the object back from file requires two
#' steps: `terra::writeRaster` then reading and re-assigning via `terra::rast`.
#' `writereadrast` wraps these into a single step.
#'
#' @param x A `terra::SpatRaster`
#' @param filename A `character` file path and name to save `x` to disc.
#' @param overwrite `logical`; overwrite existing raster.
#' @param layernames `character` of length `nlyr(x)`
#'
#' @return A `terra::SpatRaster` object reading from disc at `filename`.
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
writereadrast <- function(
    x,
    filename,
    overwrite = TRUE,
    layernames = NULL
  ){

  if(!is.null(layernames)){
    if(length(layernames) != terra::nlyr(x)){
      stop("length(layernames) != terra::nlyr(x)")
    }

    names(x) <- layernames

  }

  terra::writeRaster(
    x = x,
    filename = filename,
    overwrite = overwrite
  )

  terra::rast(x = filename)

}
