\name{convertEPMatrixToColumns}
\alias{convertEPMatrixToColumns}
\title{Convert edge prob matrix to a column matrix}
\usage{
  convertEPMatrixToColumns(epl, numberOfNodes, verbose)
}
\arguments{
  \item{epl}{A matrix of edge probability matrices, each
  corresponding to a separate bin}

  \item{numberOfNodes}{The number of nodes in the matrix}

  \item{verbose}{Should progress text be output?}
}
\description{
  Want to convert the ep list to a matrix with individual
  edges in the columns with the edges ordered according to
  as.table in splom
}
\details{
  ie 1->1, 1->2, 1->3, ... , 2->1, 2->2, ...
}

