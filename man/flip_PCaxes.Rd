% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mult-PCA.R
\name{flip_PCaxes}
\alias{flip_PCaxes}
\title{Flips PCA axes}
\usage{
flip_PCaxes(x, axs)
}
\arguments{
\item{x}{a PCA object}

\item{axs}{numeric which PC(s) to flip}
}
\description{
Simply multiply by -1, corresponding scores and rotation vectors for PCA objects.
PC orientation being arbitrary, this may help to have a better display.
}
\examples{
bp <- bot \%>\% efourier(6) \%>\% PCA
bp \%>\% plot
bp \%>\% flip_PCaxes(1) \%>\% plot()
}

