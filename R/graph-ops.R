
#' List graphs in change node neighbourhood.
#' 
#' Given a list of nodes \code{change}, get a list of \code{bn}.
#'
#' @param currentNetwork A list, containing in the first position the
#'   starting \code{bn}, and in the second position the routes matrix for
#'   that BN.
#' @param change A numeric vector, containing the nodes whose parents
#'   are to be changed.
#' @return A list of \code{bn}
#' @export
getNewGraph <- function(currentNetwork,
                        change){
  stopifnot(class(currentNetwork) == "list",
            inherits(change, "integer") || inherits(change, "numeric"))
  nodesSeq <- seq_along(currentNetwork[[1]])
  numberOfNodes <- nNodes(currentNetwork[[1]])

  # remove the old parents of node 'node1' and 'node2'
  for (node in change){
    currentNetwork[[2]] <- routesRemoveEdges(currentNetwork[[2]],
                                             currentNetwork[[1]][[node]],
                                             node)
    currentNetwork[[1]][[node]] <- integer(0)
  }

  notchange <- setdiff(nodesSeq, change)

  banned <- lapply(nodesSeq, function(i){
    setdiff(nodesSeq, i)
  })
  banned[change] <- lapply(change, function(i){
    setdiff(nodesSeq, change)
  })
  bns <- enumerateBNSpace(numberOfNodes, banned = banned)

  out <- vector("list", length(bns))
  for (i in seq_along(bns)){
    bn <- bns[[i]]
    out[[i]] <- getAllConsistentWithDAG(bn,
                                        currentNetwork,
                                        numberOfNodes,
                                        nodesSeq,
                                        change)
  }
  #browser()
  unlist(out, rec = F)
}

#' Get non-descendants of all nodes.
#' 
#' @param currentNetwork A list, containing in the first position the
#'   starting \code{bn}, and in the second position the routes matrix for
#'   that BN.
#' @return A list, each componentof which contains a list of the
#'   non-descendants of the corresponding node of the supplied BN.
#' @export
allNonDescendants <- function(currentNetwork){
  nodesSeq <- seq_along(currentNetwork[[1]])
  lapply(nodesSeq, function(node){
    nonDescendants(currentNetwork[[2]], node)
  })
}

#' Get descendants of all nodes.
#' 
#' Note that the descendants of each node includes that node!
#' 
#' @param currentNetwork A list, containing in the first position the
#'   starting \code{bn}, and in the second position the routes matrix for
#'   that BN.
#' @return A list, each componentof which contains a list of the
#'   descendants of the corresponding node of the supplied BN.
#' @export
allDescendants <- function(currentNetwork){
  nodesSeq <- seq_along(currentNetwork[[1]])
  nonDescendantsList <- allNonDescendants(currentNetwork)
  lapply(nodesSeq, function(node){
    setdiff3(nodesSeq, nonDescendantsList[[node]])
  })
}

#' Get possible parents.
#' 
#' Give a sub-bn, get the possible parents of each node.
#' 
#' @param bn A sub-bn
#' @param nonDescendantsList The output of \code{\link{allNonDescendants}}
#' @param descendantsList The output of \code{\link{allDescendants}}
#' @param numberOfNodes The number of nodes of the bn
#' @param change A numeric vector, containing the nodes whose parents
#'   are to be changed.
#' @return A list of possible parents of each node
#' @export
getPossibleParents <- function(bn,
                               nonDescendantsList,
                               descendantsList,
                               numberOfNodes,
                               change){
  possibleParents <- vector("list", length = numberOfNodes)
  for (child in change){
    possibleParentsChild <- lapply(change, function(node){
      if (node %in% bn[[child]]){
        c(descendantsList[[node]], nonDescendantsList[[node]])
      } else {
        setdiff(nonDescendantsList[[node]], node)
      }
    })
 
    possibleParents[[child]] <- do.call("intersection", possibleParentsChild)
  }
  possibleParents
}

#' Maximal banned list.
#' 
#' @param nodesSeq A sequence \code{1:numberOfNodes}
#' @return A list, which each element containing a numeric vector of the
#'   nodes that are banned from being parents of the corresponding node.
#' @export
defaultBanned <- function(nodesSeq){
  lapply(nodesSeq, function(i){
    setdiff(nodesSeq, i)
  })
}

#' Each changes choices for required.
#' 
#' @param i The node
#' @param possibleParents The output of \code{\link{getPossibleParents}}
#' @param currentNetwork A list, containing in the first position the
#'   starting \code{bn}, and in the second position the routes matrix for
#'   that BN.
#' @param change A numeric vector, containing the nodes whose parents
#'   are to be changed.
#' @param descendantsList The output of \code{\link{allDescendants}}
#' @return A table(?) of options
#' @export
eachChangesChoicesForRequired <- function(i,
                                          possibleParents,
                                          currentNetwork,
                                          change,
                                          descendantsList){
  pp <- possibleParents[[i]]
  numberOfNodes <- length(possibleParents)
  options <- do.call(list, lapply(seq_len(numberOfNodes), function(i) {
      integer(0)
  }))
  for (ch in setdiff(change, i)){
    possibleDescendants <- intersect(descendantsList[[ch]], pp)
    if (length(possibleDescendants) == 0){
      possibleDescendants <- integer(0)
    }
    options[[ch]] <- possibleDescendants
  }
  options
}

#' Remove options that don't duplicate required duplicates.
#' 
#' @param ll A list
#' @param duplicates A table giving the number of appearances of each
#' @return A logical vector
#' @export
checkForNonDuplicated <- function(ll, duplicates){
  sapply(ll, function(anoption){
    anoption2 <- unlist(anoption)
    anoption2table <- table(factor(anoption2, levels = seq_along(anoption)))
    
    ok <- T
    for (i in seq_along(anoption)){
      thisok <- anoption2table[i] == duplicates[i]
      thisok2 <- anoption2table[i] == 0
      if (all(!thisok, !thisok2)){
        ok <- F
      }
    }
    ok
  })
}

#' Remove duplicates
#' 
#' @param optionsForRequired optionsForRequired
#' @param options options
#' @return A list
#' @export
removeDuplicates <- function(optionsForRequired, options){
  out <- list()
  for (i in seq_along(options)){
    thisoptions <- options[[i]]
    thisOptionsForRequired <- optionsForRequired[[i]]
    
    thisoptions2 <- unlist(thisoptions)
    duplicates <- table(factor(thisoptions2, levels = seq_along(options)))
    
    if (length(duplicates) > 0){
      ok <- checkForNonDuplicated(thisOptionsForRequired, duplicates)
      # if (any(!ok)){
      #   browser()
      # }
    }
    out[[i]] <- thisOptionsForRequired[ok]
  }
  out
}

#' Require something from each parent.
#' 
#' @param numberOfNodes The number of nodes
#' @param nodesSeq A sequence \code{1:numberOfNodes}
#' @param possibleParents The output of \code{\link{getPossibleParents}}
#' @param change A numeric vector, containing the nodes whose parents
#'   are to be changed.
#' @param descendantsList The output of \code{\link{allDescendants}}
#' @param currentNetwork A list, containing in the first position the
#'   starting \code{bn}, and in the second position the routes matrix for
#'   that BN.
#' @return A list
#' @export
requireSomethingFromEachParent <- function(numberOfNodes,
                                           nodesSeq,
                                           possibleParents,
                                           change,
                                           descendantsList,
                                           currentNetwork){
  options <- lapply(nodesSeq, eachChangesChoicesForRequired,
                    possibleParents, currentNetwork, change, descendantsList)
  
  optionsForRequired <- lapply(options, options.grid)
  optionsForRequired <- removeDuplicates(optionsForRequired, options)
  
  ol <- lapply(optionsForRequired, length)
  ols <- lapply(ol, seq_len)
  opgrid <- expand.grid(ols)
  
  
  required <- list()
  i <- 1
  for (row in seq_len(nrow(opgrid))){
    wh <- opgrid[row, ]
    
    gr <- empty(length(wh), "bn")
    for (k in 1:length(wh)){
      this <- wh[, k]
      gr[[k]] <- unlist(optionsForRequired[[k]][[this]])
      #gr <- mapply(c, gr, newgr)
    }
    required[[i]] <- gr
    i <- i + 1
  }
  
  toBanIfNotRequired <- lapply(options, unlist)
  
  out <- list()
  z <- 1
  for (thisrequired in required){
    thisrequired <- lapply(thisrequired, unique)
    
    banned <- allBannedExceptPPNotBannedIfNotRequired(nodesSeq,
                                                      possibleParents,
                                                      change,
                                                      toBanIfNotRequired,
                                                      thisrequired)
    out[[z]] <- enumerateBNSpace(numberOfNodes,
                                 banned = banned,
                                 required = thisrequired)
    z <- z + 1
  }
  out <- unlist(out, rec = F)
  out
}

#' Make a banned list.
#' 
#' All banned except possible parents that are not required
#' 
#' @param nodesSeq A sequence \code{1:numberOfNodes}
#' @param possibleParents The output of \code{\link{getPossibleParents}}
#' @param change A numeric vector, containing the nodes whose parents
#'   are to be changed.
#' @param toBanIfNotRequired to ban if not required
#' @param required A list of required
#' @return A list
#' @export
allBannedExceptPPNotBannedIfNotRequired <- function(nodesSeq,
                                                    possibleParents,
                                                    change,
                                                    toBanIfNotRequired,
                                                    required){
  banned <- defaultBanned(nodesSeq)
  banned[change] <- lapply(change, function(i){
    allowed <- setdiff(possibleParents[[i]], toBanIfNotRequired[[i]])
    allowed <- union(allowed, required[[i]])
    setdiff(banned[[i]], allowed)
  })
  banned
}

#' Get all consistent with DAG
#' 
#' @param bn A sub-bn
#' @param currentNetwork A list, containing in the first position the
#'   starting \code{bn}, and in the second position the routes matrix for
#'   that BN.
#' @param numberOfNodes The number of nodes of the bn
#' @param nodesSeq A sequence \code{1:numberOfNodes}
#' @param change A numeric vector, containing the nodes whose parents
#'   are to be changed.
#' @return A list of possible parents of each node
#' @export
getAllConsistentWithDAG <- function(bn,
                                    currentNetwork,
                                    numberOfNodes,
                                    nodesSeq,
                                    change){
  
  nonDescendantsList <- allNonDescendants(currentNetwork)
  descendantsList <- allDescendants(currentNetwork)

  # Anything that is a descendant of anything that is not a parent in BN
  # is not allowed.
  possibleParents <- getPossibleParents(bn,
                                        nonDescendantsList,
                                        descendantsList,
                                        numberOfNodes,
                                        change)
  
  out <- requireSomethingFromEachParent(numberOfNodes,
                                 nodesSeq,
                                 possibleParents,
                                 change,
                                 descendantsList,
                                 currentNetwork)

  notchange <- setdiff(nodesSeq, change)
  outout <- lapply(out, function(net){
    net[notchange] <- currentNetwork[[1]][notchange]
    net
  })
  
  outout
}

#' input a list x.
#' 
#' return a list that includes all options, including those of varying sizes
#'
#' eg x = list(c(1,2), c(2, 3))
#' out = list(list(c(1), c(2)),
#'            list(c(2), c(2)),
#'            list(c(1, 2), c(2)),
#'            list(c(1), c(3)),
#'            list(c(2), c(3)),
#'            list(c(1, 2), c(3)),
#'            list(c(1), c(2, 3)),
#'            list(c(2), c(2, 3)),
#'            list(c(1, 2), c(2, 3)))
#' 
#' @param x A list
#' @return A list of options
#' @export
options.grid <- function(x){
  ops <- vector("list", length(x))
  for (i in 1:length(x)){
    this <- x[[i]]
    lenthis <- length(this)
    if (lenthis > 0){
      out <- list()
      for (j in 1:lenthis){
        l <- unlist(apply(combn(lenthis, j), 2, list), rec = F)
        l <- lapply(l, function(z){
          x[[i]][z]
        })
        out <- c(out, l)
      }
      ops[[i]] <- out
    } else {
      ops[[i]] <- 0
    }
  }
  lenops <- lapply(ops, length)
  seqlenops <- lapply(lenops, seq_len)
  grid <- expand.grid(seqlenops)

  out <- list()
  for (i in 1:nrow(grid)){
    out[[i]] <- vector("list", length = length(x))
    for (j in 1:ncol(grid)){
      what <- ops[[j]]
      if (!identical(what, 0)){
        out[[i]][[j]] <- what[[grid[i, j]]]
      } else {
        out[[i]][[j]] <- integer(0)
      }
    }
  }
  out
}

#' Make graph from a row.
#' 
#' @param graph A graph
#' @param change A vector of changes
#' @param row A row number
#' @return ?
#' @export
graphFromRow <- function(graph, change, row){
  rowList <- as.list(row)
  empty <- row == -1
  replace <- vector("list", sum(empty))
  rowList[empty] <- replace
  graph[change] <- rowList
  graph
}