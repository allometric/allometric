% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MixedEffectsModel.R
\name{model_call,MixedEffectsModel-method}
\alias{model_call,MixedEffectsModel-method}
\title{Get the function call for a model}
\usage{
\S4method{model_call}{MixedEffectsModel}(object)
}
\arguments{
\item{object}{The allometric model or set for which a function call will be
retrieved}
}
\value{
A string of the function call
}
\description{
The function call is the allometric model expressed as a function of its
covariates. Accessing the function call is important when determining the
order of the covariates given to the prediction function.
}
\examples{
model_call(brackett_rubra)
}
\keyword{internal}
