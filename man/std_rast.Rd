% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/std_rast.R
\name{std_rast}
\alias{std_rast}
\title{Standardise raster}
\usage{
std_rast(x, reverse, filename = NULL, overwrite = TRUE)
}
\arguments{
\item{x}{\code{SpatRaster} to standardise}

\item{reverse}{\code{logical} if \code{TRUE} will subtract standardised values from 1}

\item{filename}{Optional \code{character} path and filename to write output}

\item{overwrite}{\code{logical} if \code{TRUE} will overwrite \code{filename}}
}
\value{
A \code{SpatRaster} with range 0-1
}
\description{
Standardises all layers in a \code{SpatRaster} to a scale of 0-1,
by dividing by the maximum value in each layer. \emph{Only operates by layer}
}
\details{
Will break for non-numeric rasters
}
\examples{
example_raster(seed = 3010) |>
  std_rast(reverse = TRUE)
}
