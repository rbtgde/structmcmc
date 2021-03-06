\name{priorUniform}
\alias{priorUniform}
\title{A uniform prior for graphs.}
\usage{
  priorUniform(graph)
}
\arguments{
  \item{graph}{The 'prior graph'. A \code{bn}.}
}
\value{
  A function computes the prior score of the supplied
  graph. This This function is of a suitable form to be
  used as a prior
}
\description{
  A 'flat' improper prior that assigns equal probability to
  all the graphs.
}
\examples{
x1 <- factor(c("a", "a", "g", "c", "c", "a", "g", "a", "a"))
x2 <- factor(c(2, 2, 4, 3, 1, 4, 4, 4, 1))
x3 <- factor(c(FALSE, FALSE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE))
x <- data.frame(x1 = x1, x2 = x2, x3 = x3)

initial <- empty(3, "bn")
prior <- priorUniform()

sampler <- BNSampler(data = x, initial = initial, prior = prior)
samples <- draw(sampler, n = 100, burnin = 10)

x <- bnpostmcmc(sampler, samples)
ep(x)
}
\seealso{
  \code{\link{priorGraph}}
}

