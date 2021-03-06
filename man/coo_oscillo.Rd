% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gr-domesticplotters.R
\name{coo_oscillo}
\alias{coo_oscillo}
\title{Momocs' 'oscilloscope' for Fourier-based approaches}
\usage{
coo_oscillo(coo, method = c("efourier", "rfourier", "tfourier", "all")[4],
  nb.pts = 24)
}
\arguments{
\item{coo}{A list or a matrix of coordinates.}

\item{method}{character among \code{c('efourier', 'rfourier', 'tfourier', 'all')}.
\code{'all'} by default}

\item{nb.pts}{\code{integer}. The number or reference points, sampled
equidistantly along the curvilinear abscissa and added on the oscillo
curves.}
}
\description{
Shape analysis deals with curve fitting, whether \eqn{x(t)} and \eqn{y(t)}
positions along the curvilinear abscissa and/or radius/tangent angle variation.
These functions are mainly intended for (self-)teaching of Fourier-based methods.
}
\examples{
data(shapes)
coo_oscillo(shapes[4])
coo_oscillo(shapes[4], 'efourier')
coo_oscillo(shapes[4], 'rfourier')
coo_oscillo(shapes[4], 'tfourier')
#tfourier is prone to high-frequency noise but smoothing can help
coo_oscillo(coo_smooth(shapes[4], 10), 'tfourier')
}
\seealso{
exemplifying functions
}

