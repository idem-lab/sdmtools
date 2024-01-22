#' @title Source all R scripts in a directory
#' @description
#' Sources all scripts in a specified directory and optionally prints paths.
#'
#'
#' @param path Path of directory; default is  `/R`.
#' @param print.names Print path and name of sourced scripts. Default `TRUE`.
#'
#' @return Scripts are sourced to local environment. `NULL` returned.
#' @export
#'
#' @examples
#' #' \dontrun{
#'   source_R("/Users/frankenstein/project/R")
#' }
source_R <- function(
    path = "R",
    print.names = TRUE
){
  files <- list.files(
    path = path,
    pattern = "\\.R",
    full.names = TRUE
  )

  for (i in seq_length(files)){
    source(files[i])
    if(print.names){
      cat(
        sprintf(
          "source     %s",
          files[i]
        ),
        "\n"
      )
    }
  }

}
