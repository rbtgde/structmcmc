\name{epmx.samplers}
\alias{epmx.samplers}
\title{Edge probabilities matrix.}
\usage{
  \method{epmx}{samplers} (x, verbose = F, ...)
}
\arguments{
  \item{x}{An object of class "samplers"}

  \item{verbose}{Should progress be shown? A logical.}

  \item{...}{Further arguments (unused)}
}
\value{
  An object of class "epmx", a matrix of the form described
  above.
}
\description{
  Computes the edge probabilities and return a matrix with
  these. The format of the matrix is designed for the
  plotting function splom.epmx.
}
\details{
  For a problem with k nodes, the output will have k^2
  columns and nbin rows. Columns are in order 1->1, 1->2,
  1->3, ...., 2->1, 2->2 etc
}
\seealso{
  \code{\link{epmx}}, \code{\link{splom.epmx}},
  \code{\link{splom.bnpostmcmc.list}}
}

