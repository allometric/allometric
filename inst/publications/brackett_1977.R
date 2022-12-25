bracket_1977_citation <- RefManageR::BibEntry(
    bibtype = 'techreport',
    key = 'brackett_1977',
    title = 'Notes on tarif tree volume computation',
    author = 'Brackett, Michael',
    year = 1977,
    institution = 'State of Washington, Dept. of Natural Resources'
)

brackett_1977 <- Publication(
    citation = bracket_1977_citation,
    shared_descriptors = list(
        country = "US",
        region = "WA"
    )
)

model_descriptions <- as_tibble(load_parameter_frame('vsa_brackett_1977'))

brackett_1977 <- add_set(brackett_1977, ModelSet(
    response_unit = list(
        vsa = as_units('ft3')
    ),
    covariate_units = list(
        dsob = as_units('in'),
        hst  = as_units('ft')
    ),
    predict_fn = function(dsob, hst) {
        10^a * dsob^b * hst^c
    },
    model_descriptions = model_descriptions
))
