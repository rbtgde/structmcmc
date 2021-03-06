\name{adjustPredictions}
\alias{adjustPredictions}
\title{Adjust the predictions}
\usage{
  adjustPredictions(predictions, probabilities, n)
}
\arguments{
  \item{predictions}{An integer vector of the number of
  each category that have been predicted.}

  \item{probabilities}{A vector of probabilities}

  \item{n}{How many predictions should there be}
}
\description{
  Due to rounding, too many or too few predictions may be
  made. This functions makes the adjustments in a
  reasonable manner
}

