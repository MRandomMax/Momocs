% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coo-utilities.R
\name{coo_perim}
\alias{coo_perim}
\title{Calculates the perimeter}
\usage{
coo_perim(coo)
}
\arguments{
\item{coo}{a \code{matrix} of (x; y) coordinates.}
}
\value{
\code{numeric}, the perimeter.
}
\description{
Calculates the perimeter
}
\examples{
coo_perim(bot[1])
hist(sapply(bot$coo, coo_perim), breaks=10)
}
\seealso{
Other coo_ utilities: \code{\link{coo_aligncalliper}},
  \code{\link{coo_alignminradius}},
  \code{\link{coo_alignxax}}, \code{\link{coo_align}},
  \code{\link{coo_baseline}}, \code{\link{coo_bookstein}},
  \code{\link{coo_boundingbox}},
  \code{\link{coo_calliper}}, \code{\link{coo_centdist}},
  \code{\link{coo_center}}, \code{\link{coo_centpos}},
  \code{\link{coo_close}}, \code{\link{coo_down}},
  \code{\link{coo_dxy}}, \code{\link{coo_extract}},
  \code{\link{coo_flipx}}, \code{\link{coo_force2close}},
  \code{\link{coo_interpolate}}, \code{\link{coo_jitter}},
  \code{\link{coo_left}}, \code{\link{coo_nb}},
  \code{\link{coo_perimcum}}, \code{\link{coo_perimpts}},
  \code{\link{coo_rev}}, \code{\link{coo_right}},
  \code{\link{coo_rotatecenter}}, \code{\link{coo_rotate}},
  \code{\link{coo_samplerr}}, \code{\link{coo_sample}},
  \code{\link{coo_scalex}}, \code{\link{coo_scale}},
  \code{\link{coo_shearx}}, \code{\link{coo_slice}},
  \code{\link{coo_slidedirection}},
  \code{\link{coo_slidegap}}, \code{\link{coo_slide}},
  \code{\link{coo_smoothcurve}}, \code{\link{coo_smooth}},
  \code{\link{coo_template}}, \code{\link{coo_trans}},
  \code{\link{coo_trimbottom}}, \code{\link{coo_trimtop}},
  \code{\link{coo_trim}}, \code{\link{coo_up}},
  \code{\link{is_clockwise}}, \code{\link{is_closed}},
  \code{\link{is_equallyspacedradii}}

Other perimeter functions: \code{\link{coo_perimcum}},
  \code{\link{coo_perimpts}}
}

