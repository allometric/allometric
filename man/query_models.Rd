% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api.R
\name{query_models}
\alias{query_models}
\title{Query the model database with filters}
\usage{
query_models(
  model_type = NULL,
  country = NULL,
  region = NULL,
  family = NULL,
  genus = NULL,
  species = NULL,
  pub_id = NULL,
  citation = TRUE
)
}
\description{
This function uses the \code{models/{filter}} endpoint to retrieve multiple models
matching filter criteria. The results are returned as a \code{model_tbl}
}
