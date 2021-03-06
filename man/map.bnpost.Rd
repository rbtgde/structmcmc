\name{map.bnpost}
\alias{map.bnpost}
\title{Maximum aposteriori graph.}
\usage{
  \method{map}{bnpost} (x, ...)
}
\arguments{
  \item{x}{...}

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

map(post)
}
\seealso{
  \code{\link{map}}, \code{\link{top.bnpost}}
}

