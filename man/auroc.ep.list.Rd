\name{auroc.ep.list}
\alias{auroc.ep.list}
\title{Compute the area under an ROC curve.}
\usage{
  \method{auroc}{ep.list} (x, true, thresholds, labels,
    verbose, ...)
}
\arguments{
  \item{x}{A list of matrices of class \code{ep} of edge
  probabilities}

  \item{true}{A \code{bn}. The true graph.}

  \item{thresholds}{A numeric vector of thresholds.}

  \item{labels}{A vector of labels}

  \item{verbose}{A logical. Should progress should be
  displayed?}

  \item{...}{Further arguments (unused)}
}
\value{
  A vector of areas under ROC.
}
\description{
  Compute the area under an ROC curve for a list of edge
  probability matrices.
}
\seealso{
  For individual edge probability matrices see
  \code{\link{auroc.ep}}.
}

