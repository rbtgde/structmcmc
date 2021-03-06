\name{bayes.bn}
\alias{bayes.bn}
\title{Bayesian posterior parameter estimates.}
\usage{
  \method{bayes}{bn} (x, data, nodes = seq_along(x),
    prior = "bdeu", ...)
}
\arguments{
  \item{x}{The Bayesian Network. An object of class 'bn'}

  \item{data}{A data frame}

  \item{nodes}{A subset of 1, ..., \code{nNodes(x)}. A
  numeric vector.}

  \item{prior}{Only \code{"qi"} is implemented at the
  moment}

  \item{...}{Further arguments, passed to \code{\link{ml}}}
}
\value{
  As \code{\link{ml}}
}
\description{
  A wrapper around \code{\link{ml}}.
}
\details{
  This is the probability. This is also the expectation.
  See Neapolitean p379.
}
\examples{
d <- data.frame(
  a = factor(c(1, rep(3, 2), rep(1, 7))),
  b = factor(c(2, rep(1, 2), 3, 3, rep(2, 5))),
  c = factor(c(2, rep(2, 3), rep(1, 6))),
  d = factor(c(1:3, 2:3, 1, 1, 3:2, 2))
)

net <- bn(integer(0), integer(0), integer(0), c(1, 2, 3))
bayes(net, d, prior = "qi")
}

