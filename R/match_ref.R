#' @title match ref
#' @description Crop, resample, and mask `x` against `ref`, and optionally
#' replace any missing values.
#'
#' @param x `SpatRaster` object to bash into shape
#' @param ref `SpatRaster` reference object
#' @param missing_val If `NULL` missing value are left as is. Otherwise any
#' `NA` or `NaN` values in `x` that are not `NA` in ref will be replaced by
#' `missing_val`
#' @param filename If not `NULL` output will be written to filename
#' @param overwrite `logical`. If `filename` not `NULL`, then if `TRUE`,
#' `filename` will be overwritten.
#'
#' @return `SpatRaster` of `nlyrs(x)` trimmed to extent and resolution of `ref`.
#' @export
#'
#' @examples
#' #placeholder example
match_ref <- function(x, ref, missing_val = NULL, filename = NULL, overwrite = TRUE){

  z <- terra::crop(x, ref) |>
    terra::resample(x = _, ref) |>
    terra::mask(x = _, mask = ref)

  if(is.null(missing_val)){

    if(!is.null(filename)){
      z <- writereadrast(z, filename, overwrite)
    }

    return(z)
  }

  idx <- which(!is.na(terra::values(ref)))

  zidx <- values(z)

  zz <- apply(
    X = zidx[idx,],
    MARGIN = 2,
    FUN = function(x){
      ifelse(
        is.na(x),
        missing_val,
        ifelse(
          is.nan(x),
          missing_val,
          x
        )
      )
    }
  )

  r <- z

  zzidx <- zidx

  zzidx[idx,] <- zz

  r[] <- zzidx

  if(!is.null(filename)){
    r <- writereadrast(r, filename, overwrite)
  }

  r

}
