json_to_model_tbl <- function(json_vec) {
  lapply(json_vec, fromJSON)
}

get_models <- function(country) {
  req <- paste0(
    "https://us-west-2.aws.data.mongodb-api.com/app/application-0-nmxnm/endpoint/model?country=",
    country
  )

  res <- httr::GET(
    req
  )

  json <- jsonlite::fromJSON(rawToChar(res$content), simplifyDataFrame = FALSE)
  json_to_model_tbl(json)
}

t <- get_models("BR")

t

t$content
