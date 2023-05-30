

find_pub_dir <- function(pub_id) {
  pub_dir <- system.file("publications", package = "allometric")
  pub_dir_names <- list.files(pub_dir)

  pub_char <- substr(pub_id, 1, 1)
  matched_dir <- ""

  for(dir_name in pub_dir_names) {
    first_char <- substr(dir_name, 1, 1)
    second_char <- substr(dir_name, 3, 3)
    seq <- letters[(letters >= first_char) & (letters <= second_char)]

    if(any(grepl(pub_char, seq, fixed = TRUE))) {
      return(dir_name)
    }
  }

  stop(paste("No matching directory found for pub_id:"), pub_id)
}


generate_pub_obj <- function(pub_id, bibtype) {
  pub_id_quo <- paste("\"", pub_id, "\"", sep = "")
  bibtype_quo <- paste("\"", bibtype, "\"", sep = "")

  pub_obj <- paste(c(
    paste(pub_id, "<-", "Publication("),
    "  citation = RefManageR::BibEntry(",
    paste("    key = ", pub_id_quo, ",", sep = ""),
    paste("    bibtype = ", bibtype_quo, ",", sep = ""),
    paste("    title = ", "<title>", ",", sep = ""),
    paste("    author = ", "<author>", ",", sep = ""),
    paste("    year = ", "<year>", ",", sep = ""),
    "  )",
    ")"
  ), collapse = "\n")

  pub_obj

}

generate_fixef_model <- function() {
  fixef_mod <- paste(c(
    "<mod> <- FixedEffectsModel(",
    "  response_unit = list(",
    "    <res> = units::as_units(<res_unit>)",
    "  )",
    "  covariate_units = list(",
    "    <covt_unit1> = units::as_units(<covt_unit>)",
    "  )",
    "  parameters = list(",
    "    <parameters>",
    "  )",
    "  predict_fn = function(<covts>) {",
    "    <predict_fn>",
    "  }",
    ")"
  ), collapse = "\n")

  fixef_mod
}

generate_footer <- function(pub_id, n_fixef_models) {
  out <- c(
    paste(pub_id, "%>%")
  )

  for(i in 1:n_fixef_models) {
    out <- c(
      out,
      paste("  add_model(<mod_", i, ">)", sep="")
    )
  }

  out
}

generate_pub <- function(pub_id, bibtype, n_fixef_models = 0) {
  ## TODO do the dir finding
  pub_obj <- generate_pub_obj(pub_id, bibtype)
  text <- c(pub_obj, "")

  if(n_fixef_models > 0) {
    for(i in 1:n_fixef_models) {
      text <- c(text, generate_fixef_model(), "")
    }

    text <- c(text, generate_footer(pub_id, n_fixef_models))
  }

  pub_dir <- find_pub_dir(pub_id)
  pub_file_name <- paste(pub_id, ".R", sep = "")
  out_path <- file.path("./inst/publications/", pub_dir, pub_file_name)

  write(text, out_path)
}