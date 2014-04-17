\name{a2l}
\alias{a2l}
\title{Converts an array of coordinates to a list.}
\usage{
a2l(a)
}
\arguments{
  \item{a}{An \code{array} of coordinates.}
}
\value{
A \code{list} with 2-cols matrices of \code{(x; y)}
coordinates.
}
\description{
\code{a2l} converts an array of coordinates into a list of
2-cols matrices.
}
\examples{
#data(gorf.dat) # we import gorf.data from shapes package
#l <- a2l(gorf.dat)
#a <- l2a(l)
#A.plot(a)
}
\seealso{
\link{l2a}
}
\keyword{Utilities}
\keyword{coo}
