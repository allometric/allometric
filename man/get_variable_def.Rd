% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/variable_defs.R
\name{get_variable_def}
\alias{get_variable_def}
\title{Get the definition of a variable in the variable naming system.}
\usage{
get_variable_def(search_str, return_exact_only = FALSE)
}
\arguments{
\item{search_str}{The string to search with.}

\item{return_exact_only}{Some variables are completely defined but will
return "addditional" matches. For example, "hst" refers to the total height
of a tree, but "hstix" refers to a site index. If this argument is false, all
strings starting with "hst" will be returned. If true, then only "hst" will
be returned.}
}
\value{
A data.frame containing the matched variable definitions.
}
\description{
When possible, variables are given standard names using the variable naming
system. The definitions for a variable can be found using this function.
The \code{search_str} argument works using partial matching of the beginning of
each variable name. For example input \code{"d"} will return all diameter
definitions but input \code{"dsob"} will only return the definition for diameter
outside bark at breast height.
}
