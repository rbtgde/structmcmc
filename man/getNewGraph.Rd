\name{getNewGraph}
\alias{getNewGraph}
\title{List graphs in change node neighbourhood.}
\usage{
  getNewGraph(currentNetwork, change, maxIndegree)
}
\arguments{
  \item{currentNetwork}{A list, containing in the first
  position the starting \code{bn}, and in the second
  position the routes matrix for that BN.}

  \item{change}{A numeric vector, containing the nodes
  whose parents are to be changed.}

  \item{maxIndegree}{The maximum indegree allowed}
}
\value{
  A list of \code{bn}
}
\description{
  Given a list of nodes \code{change}, get a list of
  \code{bn}.
}

