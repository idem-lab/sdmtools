#' @title Save plot
#' @description
#' Single line wrapper to save plot as png
#'
#'
#' @param p A plot object
#' @param filename `character` to save plot
#' @param width In `units`
#' @param height In `units`. If missing, `height` will be scaled to `width` at the
#' golden ratio.
#' @param units  Units of `width` and `height`. `"px"` — pixels, the default,
#' `"cm"`, or `"mm"`. `"in"` are not allowed on principle.
#' @param res
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#'
#' lovely_plot <- plot(1:10)
#' # why use three lines
#' png("lovely_plot.png)
#' lovely_plot
#' dev.off()
#'
#' #when you could use one
#' save_plot(p = lovely_plot, "lovely_plot.png")
#'
#' }
save_plot <- function(
    p,
    filename,
    width = 2400,
    height,
    units = c("px", "cm", "mm"),
    res = 300
){

  units = match.arg(units)

  if(missing(height)){
    height <- round(width/1.62)
  }

  png(
    filename = filename,
    width = width,
    height = height,
    units = units,
    res = res
  )
  print(p)
  dev.off()

}
