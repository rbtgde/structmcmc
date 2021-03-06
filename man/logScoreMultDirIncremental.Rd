\name{logScoreMultDirIncremental}
\alias{logScoreMultDirIncremental}
\title{Multinomial-Dirichlet Log marginal likelihood (online).}
\usage{
  logScoreMultDirIncremental(currentBN, proposalBN, heads,
    logScoreParameters, cache, checkInput = T)
}
\arguments{
  \item{currentBN}{An object of class "bn".}

  \item{proposalBN}{An object of class "bn".}

  \item{heads}{A numeric vector, specifying which nodes
  have different parents in currentBN and proposalBN.}

  \item{logScoreParameters}{A list with the following
  components: \describe{ \item{data}{A matrix (NOT
  data.frame), with columns being integers in the range 0,
  1, 2, ....  giving the values of each random variable.
  **** The integers MUST start numbering at 0 NOT 1 ****}
  \item{nl}{A numeric vector of length ncol(data),
  specifying the number of levels that each random variable
  takes.} \item{hyperparameters}{A character vector of
  length one.  Either "bdeu", "qi", "one", or "point9"} }}

  \item{cache}{Optionally, provide an environment with
  cached local scores for this data.}

  \item{checkInput}{A logical of length 1, specifying
  whether to check the inputs to the function.}
}
\value{
  logscore(proposalBN) - logscore(currentBN)
}
\description{
  Compute the difference in log marginal likelihood of the
  supplied Bayesian Networks, quickly.
}
\details{
  This is a fast, incremental version of logScoreMultDir.

  *** NOTE: THIS REQUIRES A MATRIX RATHER THAN A DATA FRAME
  ***

  The data must be discrete. The conditional distributions
  of each random variable, conditional on its parents are
  assumed to be multinomial, with Dirichlet priors for the
  parameters.

  The notation here roughly follows Mukherjee and Speed
  (2008) Network inference using informative priors. PNAS
  105 (38) 14313-14318, doi: 10.1073/pnas.0802272105
}
\examples{
x1 <- factor(c(1, 1, 0, 1, 0, 0, 1, 0, 1, 0))
x2 <- factor(c(0, 1, 0, 1, 0, 1, 1, 0, 1, 0))
x3 <- factor(c(0, 1, 1, 1, 0, 1, 1, 0, 1, 0))
data <- data.frame(x1 = x1, x2 = x2,  x3 = x3)

n1 <- bn(numeric(0), 1, 2)
n2 <- bn(numeric(0), 1, numeric(0))

logScoreMultDir(n1, data)
logScoreMultDir(n2, data)

data <- data.frame(lapply(data, as.factor))
data <- data.matrix(data) - 1
cc <- new.env(hash = TRUE, size = 10000L)
nl <- apply(data, 2, function(i) length(unique(i)))
names(nl) <- seq_along(n1)
lsp <- list(data = data, nl = nl, hyperparameters = "qi")
logScoreMultDirIncremental(n1, n2, 3, lsp, cc)
}
\seealso{
  \code{\link{logScoreMultDir}},
  \code{\link{logScoreMultDirOffline}}
}

