\name{logScoreNormal}
\alias{logScoreNormal}
\title{Normal-inverse-gamma (with g-prior) Log marginal likelihood.}
\usage{
  logScoreNormal(x, ...)
}
\arguments{
  \item{x}{...}

  \item{...}{Further arguments passed to method}
}
\description{
  method description
}
\examples{
data <- cbind(c(-10, -2), c(-11, -4))
net <- bn(integer(0), 1)
logScoreNormal(net, data)
}
\seealso{
  \code{\link{logScoreNormal.bn}}
}

