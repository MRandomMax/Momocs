##### Core function for radii variation Fourier analyses

#' Radii variation Fourier transform (equally spaced radii)
#'
#' \code{rfourier} computes radii variation Fourier analysis from a matrix or a
#' list of coordinates where points are equally spaced radii.
#'
#' @param x A \code{list} or \code{matrix} of coordinates or an \code{Out} object
#' @param nb.h \code{integer}. The number of harmonics to use. If missing, 12 is used on shapes;
#' 99 percent of harmonic power on Out objects, both with messages.
#' @param smooth.it \code{integer}. The number of smoothing iterations to
#' perform.
#' @param norm \code{logical}. Whether to scale the outlines so that the mean
#' length of the radii used equals 1.
#' @param thres \code{numeric} a tolerance to feed \link{is_equallyspacedradii}
#' @param verbose \code{logical}. Whether to display diagnosis messages.
#' @param ... useless here
#' @return A list with following components:
#' \itemize{
#'  \item \code{an} vector of \eqn{a_{1->n}} harmonic coefficients
#'  \item \code{bn} vector of \eqn{b_{1->n}} harmonic coefficients
#'  \item \code{ao} ao harmonic coefficient.
#'  \item \code{r} vector of radii lengths.
#'  }
#' @details see the JSS paper for the maths behind. The methods for \code{Out} objects
#'  tests if coordinates have equally spaced radii using \link{is_equallyspacedradii}. A
#'  message is printed if this is not the case.
#' @family rfourier
#' @note Directly borrowed for Claude (2008), and called \code{fourier1} there.
#' @references Claude, J. (2008) \emph{Morphometrics with R}, Use R! series,
#' Springer 316 pp.
#' @examples
#' data(bot)
#' coo <- coo_center(bot[1]) # centering is almost mandatory for rfourier family
#' coo_plot(coo)
#' rf  <- rfourier(coo, 12)
#' rf
#' rfi <- rfourier_i(rf)
#' coo_draw(rfi, border='red', col=NA)
#'
#' # Out method
#' bot %>% rfourier()
#' @rdname rfourier
#' @export
rfourier <- function(x, ...){UseMethod("rfourier")}

#' @rdname rfourier
#' @export
rfourier.default <- function(x, nb.h, smooth.it = 0, norm = FALSE, verbose = TRUE, ...) {
    coo <- x
    coo <- coo_check(coo)
    if (missing(nb.h)) {
      nb.h <- 12
      message("'nb.h' not provided and set to ", nb.h)
    }
    if (is_closed(coo)) {
        coo <- coo_unclose(coo)
    }
    if (nb.h * 2 > nrow(coo) | missing(nb.h)) {
        nb.h = floor(nrow(coo)/2)
        if (verbose) {
            message("'nb.h' must be lower than half the number of points and has been set to: ",
                nb.h)
        }
    }
    if (nb.h == -1) {
        nb.h = floor(nrow(coo)/2)
        if (verbose) {
            message("'nb.h' must be lower than half the number of points and has been set to",
                nb.h, "harmonics.\n")
        }
    }
    if (smooth.it != 0) {
        coo <- coo_smooth(coo, smooth.it)
    }
    if (norm) {
        coo <- coo_scale(coo_center(coo))
        rsize <- mean(apply(coo, 1, function(x) sqrt(sum(x^2))))
        coo <- coo_scale(coo, 1/rsize)
    }
    # from Claude
    p <- nrow(coo)
    an <- bn <- numeric(nb.h)
    Z <- complex(real = coo[, 1], imaginary = coo[, 2])
    r <- Mod(Z)
    angle <- Arg(Z)
    ao <- 2 * sum(r)/p
    for (i in 1:nb.h) {
        an[i] <- (2/p) * sum(r * cos(i * angle))
        bn[i] <- (2/p) * sum(r * sin(i * angle))
    }
    list(an = an, bn = bn, ao = ao, r = r)
}

#' @rdname rfourier
#' @export
rfourier.Out <- function(x, nb.h = 40, smooth.it = 0, norm = TRUE, thres=pi/90, verbose=TRUE, ...) {
  Out <- x
  # validates
  Out %<>% validate()
  # tests if we actually have equally spaced radii
  esr <- Out %>% is_equallyspacedradii(thres=thres)
  if (any(is.na(esr)))
    message("some shapes seem(s) to have some identical coordinates\n")
  if (any(!na.omit(esr)))
    message("some shape(s) seem(s) to have non equally spaced radii\n")
  q <- floor(min(sapply(Out$coo, nrow)/2))
  if (missing(nb.h)) {
    # nb.h <- ifelse(q >= 32, 32, q)
    nb.h <- calibrate_harmonicpower(Out, method="rfourier",
                                    thresh = 99, verbose=FALSE, plot=FALSE)$minh
    if (verbose) message("'nb.h' not provided and set to ", nb.h, " (99% harmonic power)")
  }
  if (nb.h > q) {
    nb.h <- q  # should not be 1 #todo
    message("at least one outline has no more than ", q * 2,
        " coordinates. 'nb.h' has been set to ", q,
        " harmonics")
  }
  coo <- Out$coo
  col.n <- paste0(rep(LETTERS[1:2], each = nb.h), rep(1:nb.h,
                                                      times = 2))
  coe <- matrix(ncol = 2 * nb.h, nrow = length(coo), dimnames = list(names(coo),
                                                                     col.n))
  for (i in seq(along = coo)) {
    rf <- rfourier(coo[[i]], nb.h = nb.h, smooth.it = smooth.it,
                   norm = norm, verbose = TRUE)  #todo: vectorize
    coe[i, ] <- c(rf$an, rf$bn)
  }
  res <- OutCoe(coe = coe, fac = Out$fac, method = "rfourier", norm = norm)
  res$cuts <- ncol(res$coe)
  return(res)
}

#' Inverse radii variation Fourier transform
#'
#' \code{rfourier_i} uses the inverse radii variation (equally spaced radii) transformation to
#' calculate a shape, when given a list with Fourier coefficients, typically
#' obtained computed with \link{rfourier}.
#'
#'
#' @param rf A \code{list} with \code{ao}, \code{an} and \code{bn} components,
#' typically as returned by \code{rfourier}.
#' @param nb.h \code{integer}. The number of harmonics to calculate/use.
#' @param nb.pts \code{integer}. The number of points to calculate.
#' @return A list with components: \item{x }{\code{vector} of
#' \code{x}-coordinates.} \item{y }{\code{vector} of \code{y}-coordinates.}
#' \item{angle}{\code{vector} of angles used.} \item{r}{\code{vector} of radii
#' calculated.}
#' @family rfourier
#' @details See the JSS paper for the maths behind.
#' @note Directly borrowed for Claude (2008), and called \code{ifourier1} there.
#' @references Claude, J. (2008) \emph{Morphometrics with R}, Use R! series,
#' Springer 316 pp.
#' @examples
#' data(bot)
#' coo <- coo_center(bot[1]) # centering is almost mandatory for rfourier family
#' coo_plot(coo)
#' rf  <- rfourier(coo, 12)
#' rf
#' rfi <- rfourier_i(rf)
#' coo_draw(rfi, border='red', col=NA)
#'
#' @export
rfourier_i <- function(rf, nb.h, nb.pts = 120) {
    if (!all(c("an", "bn") %in% names(rf))) {
        stop("a list containing 'an' and 'bn' harmonic coefficients must be provided")
    }
    ao <- ifelse(is.null(rf$ao), 1, rf$ao)
    an <- rf$an
    bn <- rf$bn
    if (missing(nb.h)) {
        nb.h <- length(an)
    }
    if (nb.h > length(an)) {
        nb.h <- length(an)
        message("nb.h cannot be higher than length(rf$an) and has been set to ", nb.h)
    }
    theta <- seq(0, 2 * pi, length = nb.pts)
    harm <- matrix(NA, nrow = nb.h, ncol = nb.pts)
    for (i in 1:nb.h) {
        harm[i, ] <- an[i] * cos(i * theta) + bn[i] * sin(i * theta)
    }
    r <- (ao/2) + apply(harm, 2, sum)
    Z <- complex(modulus = r, argument = theta)
    x <- Re(Z)
    y <- Im(Z)
    coo <- cbind(x, y)
    colnames(coo) <- c("x", "y")
    return(coo)
}

#' Calculates and draw 'rfourier' shapes.
#'
#' \code{rfourier_shape} calculates a 'Fourier radii variation shape' given
#' Fourier coefficients (see \code{Details}) or can generate some 'rfourier'
#' shapes.
#'
#' \code{rfourier_shape} can be used by specifying \code{nb.h} and
#' \code{alpha}. The coefficients are then sampled in an uniform distribution
#' \eqn{(-\pi ; \pi)} and this amplitude is then divided by
#' \eqn{harmonicrank^alpha}. If \code{alpha} is lower than 1, consecutive
#' coefficients will thus increase. See \link{rfourier} for the mathematical
#' background.
#'
#' @param an \code{numeric}. The \eqn{a_n} Fourier coefficients on which to
#' calculate a shape.
#' @param bn \code{numeric}. The \eqn{b_n} Fourier coefficients on which to
#' calculate a shape.
#' @param nb.h \code{integer}. The number of harmonics to use.
#' @param nb.pts \code{integer}. The number of points to calculate.
#' @param alpha \code{numeric}. The power coefficient associated with the
#' (usually decreasing) amplitude of the Fourier coefficients (see
#' \bold{Details}).
#' @param plot \code{logical}. Whether to plot or not the shape.
#' @return A matrix of (x; y) coordinates.
#' @family rfourier
#' @references Claude, J. (2008) \emph{Morphometrics with R}, Use R! series,
#' Springer 316 pp.
#' @examples
#' data(bot)
#' rf <- rfourier(bot[1], 24)
#' rfourier_shape(rf$an, rf$bn) # equivalent to rfourier_i(rf)
#' rfourier_shape() # not very interesting
#'
#' rfourier_shape(nb.h=12) # better
#' rfourier_shape(nb.h=6, alpha=0.4, nb.pts=500)
#'
#' # Butterflies of the vignette' cover
#' panel(Out(a2l(replicate(100,
#' rfourier_shape(nb.h=6, alpha=0.4, nb.pts=200, plot=FALSE)))))
#' @export
rfourier_shape <- function(an, bn, nb.h, nb.pts = 80, alpha = 2,
    plot = TRUE) {
    if (missing(nb.h) & missing(an))
        nb.h <- 6
    if (missing(nb.h) & !missing(an))
        nb.h <- length(an)
    if (missing(an))
        an <- runif(nb.h, -pi, pi)/(1:nb.h)^alpha
    if (missing(bn))
        bn <- runif(nb.h, -pi, pi)/(1:nb.h)^alpha
    rf <- list(an = an, bn = bn, ao = 0)
    shp <- rfourier_i(rf, nb.h = nb.h, nb.pts = nb.pts)
    if (plot)
        coo_plot(shp)
    return(shp)
}

##### end rfourier
