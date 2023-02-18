eng_2012 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "inproceedings",
    key = "eng_2012",
    author = "Eng, Helge",
    title = "Tree height estimation in redwood/Douglas-fir stands in Mendocino County",
    booktitle = "Proceedings of the coast redwood forests in a changing California: A symposium for scientists and managers",
    pages = "649--656",
    year = 2012,
    organization = "USDA For. Serv., Gen. Tech. Rep. PSW-GTR-238, Pacific Southwest Research Station"
  ),
  descriptors = list(
    country = "US",
    state = "US-CA"
  )
)

params <- load_parameter_frame('hst_eng_2012')

predict_fns <- list(
  function(dsob) {4.5 + exp(a + b * dsob^c)},
  function(dsob) {a * (1 - exp(b * dsob^c))},
  function(asc, dsob) {a_0 + a_1 * asc + b * dsob^c},
  function(asc, rc, dsob) {4.5 + exp(a_0 + a_1 * asc + a_2 * rc + b * dsob^c)}
)

asc_description <- list(asc = "Aggregated site class, 1 denotes site class II or better, 0 denotes site class III or worse.")

covt_units <- list(
  list(dsob = units::as_units("in")),
  list(dsob = units::as_units("in")),
  list(asc = units::unitless, dsob = units::as_units("in")),
  list(asc = units::unitless, rc = units::as_units("ft / ft"), dsob = units::as_units("in"))
)

eq_nos <- unique(params$eq_no)

for(eq_no in eq_nos) {
  params_eq <- params %>%
    dplyr::filter(eq_no == {{eq_no}}) %>%
    dplyr::select_if(~sum(!is.na(.)) > 0)

  param_names <- colnames(params_eq)[!colnames(params_eq) %in% c("family", "genus", "species", "eq_no")]


  model_specifications <- params_eq %>% dplyr::select(-c(eq_no))

  predict_fn <- predict_fns[[eq_no]]

  if(eq_no %in% c(1, 2)) {
    set <- FixedEffectsSet(
      response_unit = list(
        hst = units::as_units("ft")
      ),
      covariate_units = covt_units[[eq_no]],
      parameter_names = param_names,
      predict_fn = predict_fn,
      model_specifications = model_specifications
    )
  } else {
    set <- FixedEffectsSet(
      response_unit = list(
        hst = units::as_units("ft")
      ),
      covariate_units = covt_units[[eq_no]],
      parameter_names = param_names,
      predict_fn = predict_fn,
      model_specifications = model_specifications,
      covariate_definitions = asc_description
    )
  }

  eng_2012 <- eng_2012 %>% add_set(set)
}