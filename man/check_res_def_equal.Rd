% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eq.R
\name{check_res_def_equal}
\alias{check_res_def_equal}
\title{Check for equivalence of the response definition}
\usage{
check_res_def_equal(mod1, mod2)
}
\arguments{
\item{mod1}{A model object}

\item{mod2}{A model object}
}
\description{
The response definitions are strings or NA. If both are NA, they are
considered equal, otherwise the strings are checked for equivalence.
}
\keyword{internal}
