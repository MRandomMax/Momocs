% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/babel-import.R
\name{tps2coo}
\alias{tps2coo}
\title{Reads a single tps-like shape as lines}
\usage{
tps2coo(tps, curves = TRUE)
}
\arguments{
\item{tps}{lines, typically from \link{readLines}, describing a single shape in tps-like format}

\item{curves}{\code{logical} whether to read curves, if any}
}
\value{
a list with components:
\code{coo} a matrix of coordinates; \code{cur} a list of matrices; \code{scale} the scale as a numeric.
}
\description{
Internal function used in \link{import_tps} that may be useful for data import. When provided
with lines (eg after \link{readLines}) from a tps-like description (with "LM", "CURVES", etc.) returns a list of
coordinates, curves, etc.
}
\details{
if curves are present add them to \code{$coo} (with the proper combination
of \link{do.call}, \link{rbind}, then use \link{def_slidings} or define a slidings matrix (see \link{Ldk}).
}
\examples{
\dontrun{
# let's imagine this command works fine
coo <- import_tps(...)
# then you can
Ldk(coo)
}
}
\seealso{
Other babel functions: \code{\link{bind_db}},
  \code{\link{chc2Out}}, \code{\link{chc2pix}},
  \code{\link{import_StereoMorph_curve1}},
  \code{\link{import_jpg}}, \code{\link{import_tps}},
  \code{\link{nef2Coe}}, \code{\link{ntsrow2Coo}},
  \code{\link{pix2chc}}, \code{\link{tie_jpg_txt}}
}

