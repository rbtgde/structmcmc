\name{is.valid.prior}
\alias{is.valid.prior}
\title{Check validity.}
\usage{
  \method{is.valid}{prior} (x)
}
\arguments{
  \item{x}{A numeric of length 1. The LOG output of a prior
  function.}
}
\value{
  A logical of length 1, indicating the validity of x
}
\description{
  Checks the output of a LOG prior for validity. Basically
  is it positive?
}

