% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cl-handling.R
\name{filter}
\alias{filter}
\title{Filters (ala dplyr) on Momocs objects}
\usage{
filter(.data, ...)
}
\arguments{
\item{.data}{a \code{Coo}, \code{Coe}, \code{PCA} object}

\item{...}{logical conditions}
}
\value{
a Momocs object of the same class.
}
\description{
Return shapes with matching conditions, from the \code{$fac}. See examples and \code{?dplyr::filter}.
}
\details{
dplyr verbs are maintained.
}
\examples{
olea
# we retain on dorsal views
filter(olea, view=="VD")
# only dorsal views and Aglan+PicMa varieties
filter(olea, view=="VD", var \%in\% c("Aglan", "PicMa"))
# we create an id column and retain the 120 first shapes
olea \%>\% mutate(id=1:length(olea)) \%>\% filter(id > 120)
}
\seealso{
Other handling functions: \code{\link{arrange}},
  \code{\link{at_least}}, \code{\link{chop}},
  \code{\link{combine}}, \code{\link{dissolve}},
  \code{\link{mutate}}, \code{\link{rename}},
  \code{\link{rm_uncomplete}}, \code{\link{rw_fac}},
  \code{\link{sample_frac}}, \code{\link{sample_n}},
  \code{\link{select}}, \code{\link{slice}},
  \code{\link{subset.Coo}}, \code{\link{transmute}}
}

