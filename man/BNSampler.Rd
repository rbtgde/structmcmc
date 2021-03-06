\name{BNSampler}
\alias{BNSampler}
\title{Create a MCMC sampler (MC^3) for Bayesian Networks.}
\usage{
  BNSampler(data, initial, prior, return = "network",
    logScoreFUN = logScoreMultDirFUN(),
    logScoreParameters = list(hyperparameters = "bdeu"),
    constraint = NULL, statistics = list(nEdges = nEdges),
    maxNumberParents = NULL, verbose = F, keepTape = F)
}
\arguments{
  \item{data}{The data.}

  \item{initial}{An object of class 'bn'. The starting
  value of the MCMC.}

  \item{prior}{EITHER A function that returns the prior
  score of the supplied bn.  OR A list of functions of the
  same length as \code{initial} that returns the local
  prior score of the corresponding node, given a numeric
  vector of parents. The default value \code{NULL} uses an
  improper uniform prior.}

  \item{return}{Either "network" or "contingency".}

  \item{logScoreFUN}{A list of four elements: \describe{
  \item{offline}{A function that computes the logScore of a
  Bayesian Network} \item{online}{A function that
  incrementally computes the logScore of a Bayesian
  Network} \item{local}{A function that computes the local
  logScore of a Bayesian Network} \item{prepare}{A function
  that prepares the data, and any further pre-computation
  required by the logScore functions.} } For
  Multinomial-Dirichlet models,
  \code{\link{logScoreMultDirFUN}} returns the appropriate
  list; for Normal models with Zellner g-priors,
  \code{\link{logScoreNormalFUN}} returns the appropriate
  list.}

  \item{logScoreParameters}{A list of parameters that are
  passed to logScoreFUN.}

  \item{constraint}{A matrix of dimension ncol(data) x
  ncol(data) giving constraints to the sample space. The
  (i, j) element is: \describe{ \item{1}{if the edge i -> j
  is required} \item{-1}{if the edge i -> is excluded.}
  \item{0}{if the edge i -> j is not constrained.} } The
  diagonal of constraint must be all 0.}

  \item{statistics}{A named list of functions which should
  be applied to the current network after each step. Each
  function should accept an object of class \code{bn} and
  return a scalar output. Each item in the list must be
  named so that it can be referred to.}

  \item{maxNumberParents}{Integer of length 1. The maximum
  number of parents of any node. The default value, which
  is used for \code{NULL} is to not constrain the maximum
  indegree, i.e. to use \code{ncol(data) - 1}.}

  \item{verbose}{A logical of length 1, indicating whether
  verbose output should be printed.}

  \item{keepTape}{A logical of length 1, indicating whether
  a full log (\code{tape}) of the MCMC sampler should be
  kept. Enabling this option can be very memory-intensive.}
}
\value{
  A function, which when called draws the next sample of
  the MCMC.
}
\description{
  The sampler samples Bayesian Networks (ie models).
}
\examples{
x1 <- factor(c("a", "a", "g", "c", "c", "a", "g", "a", "a"))
x2 <- factor(c(2, 2, 4, 3, 1, 4, 4, 4, 1))
x3 <- factor(c(FALSE, FALSE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE))
x <- data.frame(x1 = x1, x2 = x2, x3 = x3)

initial <- empty(3, "bn")
prior <- priorUniform(initial)

sampler <- BNSampler(data = x, initial = initial, prior = prior)
samples <- draw(sampler, n = 100, burnin = 10)

x <- bnpostmcmc(sampler, samples)
ep(x)
}
\seealso{
  \code{\link{draw}}. \code{\link{BNSamplerMJ}},
  \code{\link{BNSamplerPT}}, \code{\link{BNGibbsSampler}}.
  Example priors \code{\link{priorGraph}},
  \code{\link{priorUniform}}
}

