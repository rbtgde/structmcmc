\name{priorGraph}
\alias{priorGraph}
\title{A standard 'graph prior'.}
\usage{
  priorGraph(graph, lambda)
}
\arguments{
  \item{graph}{The 'prior graph'. A \code{bn}.}

  \item{lambda}{A weighting parameter. A numeric of length
  1.}
}
\value{
  A function computes the prior score of the supplied
  graph. This This function is of a suitable form to be
  used as a prior.
}
\description{
  Returns a function that will evaluate the prior of a
  graph. The prior is
}
\details{
  f(x) = exp( - lambda * (edges(x) - edges(graph)))

  So the prior scores more highly those graphs \code{x}
  that include all the edges in the graph \code{graph};
  extra edges are penalised; the prior is maximised (not
  uniquely) at the empty graph.
}
\examples{
x1 <- factor(c("a", "a", "g", "c", "c", "a", "g", "a", "a"))
x2 <- factor(c(2, 2, 4, 3, 1, 4, 4, 4, 1))
x3 <- factor(c(FALSE, FALSE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE))
x <- data.frame(x1 = x1, x2 = x2, x3 = x3)

priorgraph <- bn(c(), 1, 2)
prior <- priorGraph(priorgraph, 0.5)

initial <- empty(3, "bn")
sampler <- BNSampler(data = x, initial = initial, prior = prior)
samples <- draw(sampler, n = 100, burnin = 10)

x <- bnpostmcmc(sampler, samples)
ep(x)
}
\seealso{
  \code{\link{priorUniform}}
}

