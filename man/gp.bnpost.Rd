\name{gp.bnpost}
\alias{gp.bnpost}
\title{Posterior graph probaiblities.}
\usage{
  \method{gp}{bnpost} (x, log = F, pretty = F, ...)
}
\arguments{
  \item{x}{...}

  \item{log}{...}

  \item{pretty}{...}

  \item{...}{Further arguments (unused)}
}
\description{
  method description
}
\examples{
x1 <- factor(c(1, 1, 0, 1))
x2 <- factor(c(0, 1, 0, 1))
dat <- data.frame(x1 = x1, x2 = x2)

bnspace <- enumerateBNSpace(2)
lsmd <- logScoreMultDir(bnspace, data = dat, hyperparameters = "bdeu")
post <- bnpost(bnspace = bnspace, logScore = lsmd, data = dat)

gp(post)
ep(post)
}
\seealso{
  \code{\link{gp}}, \code{\link{ep.bnpost}}
}

