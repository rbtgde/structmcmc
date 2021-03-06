\name{summary.gp}
\alias{summary.gp}
\title{Summary of posterior graph probabilities.}
\usage{
  \method{summary}{gp} (object, ...)
}
\arguments{
  \item{object}{...}

  \item{...}{Further arguments passed to method}
}
\description{
  method description
}
\examples{
x1 <- factor(c(1, 1, 0, 1))
x2 <- factor(c(0, 1, 0, 1))
x <- data.frame(x1 = x1, x2 = x2)

exact <- posterior(data = x, "exact")

mygp <- gp(exact)
summary(mygp)
}
\seealso{
  \code{\link{gp}}
}

