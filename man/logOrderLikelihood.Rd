\name{logOrderLikelihood}
\alias{logOrderLikelihood}
\title{Sample the parents of a single node (Gibbs sampler).}
\usage{logOrderLikelihood(order, numberOfNodes, nodesSeq,
    scoresParents, parentsTables, allRows, rowsThatContain)}

\description{
  Sample the parents of a single node (Gibbs sampler).
}

\details{
  Sample from posterior distribution on graph, conditional
  on all the edges, except those that go into node
  \code{node}.
}
\value{Returns the sampled network. A \code{currentNetwork} object.}
\seealso{\code{\link{BNGibbsSampler}}, \code{\link{samplePair}}}
\arguments{
  \item{order}{A vector length \code{numberOfNodes}, giving a permuation
of \code{1:numberOfNodes}.}
  \item{numberOfNodes}{The number of nodes in the network. A numeric vector 
of length 1.}
  \item{nodesSeq}{The vector 1:nNodes(currentNetwork). (Supplied as an 
argument for possible speed gain)}
  \item{scoresParents}{A list of the form returned by 
\code{scoreParentsTable()}}
  \item{parentsTables}{A list of tables of the form returned by 
\code{enumerateParentsTable()}}
  \item{allRows}{The vector 1:nrow(parentsTables). (Supplied as an 
argument for possible speed gain)}
  \item{rowsThatContain}{A list of the form created by 
\code{getRowsThatContain()}}
}