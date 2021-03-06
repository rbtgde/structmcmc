\name{logScoreNormalOffline}
\alias{logScoreNormalOffline}
\title{Normal-inverse-gamma (with g-prior) Log marginal likelihood (offline).}
\usage{
  logScoreNormalOffline(x, logScoreParameters,
    cache = new.env(hash = T), checkInput = T)
}
\arguments{
  \item{x}{An object of class "bn". The Bayesian Network by
  for which the marginal likelihood is computed.}

  \item{logScoreParameters}{A list with the following
  components: \describe{ \item{data}{A matrix with columns
  giving the values of each random variable.} \item{nl}{A
  numeric vector of length nNodes(currentBN), specifying
  the number of levels that each random variable takes.} }}

  \item{cache}{Optionally, provide an environment with
  cached local scores for this data.}

  \item{checkInput}{A logical of length 1, specifying
  whether to check the inputs to the function.}
}
\value{
  A numeric vector of length 1, giving the log marginal
  likelihood.  The environment 'cache' will also be updated
  because its scope is global.
}
\description{
  Compute the log marginal likelihood of the supplied
  Bayesian Network.
}
\details{
  This function is an alternative interface to
  logScoreNormal. This interface is required by the MCMC
  sampler.
}
\seealso{
  \code{\link{logScoreNormal}},
  \code{\link{logScoreNormalIncremental}}
}

