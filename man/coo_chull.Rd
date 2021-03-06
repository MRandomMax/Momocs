% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coo-shapedescriptors.R
\name{coo_chull}
\alias{coo_chull}
\title{Calculates the convex hull of a shape}
\usage{
coo_chull(coo)
}
\arguments{
\item{coo}{a \code{matrix} of (x; y) coordinates.}
}
\value{
a \code{matrix} of ids defining the convex hull of the shape.
}
\description{
Returns the ids of points that define the convex hull of a shape. A simple wrapper
around \link{chull}, mainly used in graphical functions.
}
\examples{
data(hearts)
h <- coo_sample(hearts[4], 32)
coo_plot(h)
ch <- coo_chull(h)
lines(ch, col='red', lty=2)
}
\seealso{
Other coo_ descriptors: \code{\link{coo_area}},
  \code{\link{coo_boundingbox}},
  \code{\link{coo_circularityharalick}},
  \code{\link{coo_circularitynorm}},
  \code{\link{coo_circularity}},
  \code{\link{coo_convexity}},
  \code{\link{coo_eccentricityboundingbox}},
  \code{\link{coo_eccentricityeigen}},
  \code{\link{coo_elongation}}, \code{\link{coo_length}},
  \code{\link{coo_lw}}, \code{\link{coo_rectangularity}},
  \code{\link{coo_rectilinearity}},
  \code{\link{coo_solidity}}, \code{\link{coo_tangle}},
  \code{\link{coo_theta3}}, \code{\link{coo_thetapts}},
  \code{\link{coo_width}}
}

