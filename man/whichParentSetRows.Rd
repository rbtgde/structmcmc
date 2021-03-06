\name{whichParentSetRows}
\alias{whichParentSetRows}
\title{Find relevants rows of a parentsTable.}
\usage{
  whichParentSetRows(node, nonDescendants,
    needOneOf = NULL, numberOfNodes, allRows,
    rowsThatContain, blankBit)
}
\arguments{
  \item{node}{The node. A numeric vector of length 1.}

  \item{nonDescendants}{The nodes that can be added as
  descendants of \code{node}. A numeric vector.}

  \item{needOneOf}{Nodes the MUST be included as parents of
  the node. This is NOT the same as the required/banned
  list; this is to allow the space to be partitioned.}

  \item{numberOfNodes}{The number of nodes in the network.
  A numeric vector of length 1.}

  \item{allRows}{The vector 1:nrow(parentsTables).
  (Supplied as an argument for possible speed gain)}

  \item{rowsThatContain}{A list of the form created by
  \code{getRowsThatContain()}}
}
\value{
  A numeric vector.
}
\description{
  Finds the rows of a parentsTable that correspond to
  parent sets that could be added as parents of node
  \code{node}, given some set of nodes
  \code{nonDescendants} that can be added as parents
  without creating a cycle in the graph.
}
\details{
  Note that nodes that are banned do not need to be
  accounted for in the \code{nonDescendants} argument,
  since these should be accounted for when the parentsTable
  is created. Required nodes must be included in
  \code{nonDescendants}.
}
\seealso{
  \code{\link{enumerateParentsTable}},
  \code{\link{scoreParentsTable}}
}

