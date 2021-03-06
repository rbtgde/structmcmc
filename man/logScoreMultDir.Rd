\name{logScoreMultDir}
\alias{logScoreMultDir}
\title{Multinomial-Dirichlet Log marginal likelihood.}
\usage{
  logScoreMultDir(x, ...)
}
\arguments{
  \item{x}{A \code{bn}.}

  \item{...}{Further arguments, passed to method}
}
\description{
  method description
}
\examples{
x1 <- factor(c(1, 1, 0, 1, 0, 0, 1, 0, 1, 0))
x2 <- factor(c(0, 1, 0, 1, 0, 1, 1, 0, 1, 0))
x3 <- factor(c(0, 1, 1, 1, 0, 1, 1, 0, 1, 0))
data <- data.frame(x1 = x1, x2 = x2,  x3 = x3)
logScoreMultDir(bn(integer(0), 1, 2), data)
}
\seealso{
  \code{\link{logScoreMultDir.bn}},
  \code{\link{logScoreMultDir.bn.list}},
  \code{\link{logScoreMultDirOffline}},
  \code{\link{logScoreMultDirIncremental}}
}

