\name{dotplot.ep.list}
\alias{dotplot.ep.list}
\title{Dotplot of list of posterior edge probabilities.}
\usage{
  \method{dotplot}{ep.list} (eplist, subsetBy = "Exact",
    head = 30, ...)
}
\arguments{
  \item{eplist}{A *NAMED* list of edge probability
  matrices.}

  \item{subsetBy}{...}

  \item{head}{...}

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
mcmc <- posterior(data = x, "mc3", nSamples = 500, nBurnin = 100)

myep1 <- ep(exact)
myep2 <- ep(mcmc)
if (require(lattice)){
  dotplot(ep.list(Exact = myep1, MCMC = myep2))
}
}
\seealso{
  \code{\link{dotplot.ep}}
}

