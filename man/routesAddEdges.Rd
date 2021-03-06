\name{routesAddEdges}
\alias{routesAddEdges}
\title{Update a routes matrix (edge addition).}
\usage{
  routesAddEdges(x, i, j)
}
\arguments{
  \item{x}{A routes matrix}

  \item{i}{The nodes from which the added edge emanates}

  \item{j}{The node that the added edge goes to. ONLY ONE
  NODE HERE}
}
\description{
  A routes matrix is a matrix A, such that each element (i,
  j) is the number of routes from i to j in some directed
  graph.
}
\details{
  This function updates the routes matrix to account for
  the addition of an edge from i to j in the directed graph
}
\seealso{
  \code{\link{routesRemoveEdges}},
  \code{\link{nonDescendants}}
}

