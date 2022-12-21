bracket_1977_citation <- RefManageR::BibEntry(
    bibtype = 'techreport',
    key = 'brackett_1977',
    title = 'Notes on tarif tree volume computation',
    author = 'Brackett, Michael',
    year = 1977,
    institution = 'State of Washington, Dept. of Natural Resources'
)

brackett_1977 <- Publication(
    citation = bracket_1977_citation
)

parameter_set <- load_parameter_set('vsa_brackett_1977')

brackett_1977 <- add_family(brackett_1977, ParametricFamily(
    response_unit = list(
        vsa = as_units('ft3')
    ),
    covariate_units = list(
        dsob = as_units('in'),
        hst  = as_units('ft')
    ),
    predict_fn = function(p, x) {
        10^p$a * x$dsob^p$b * x$hst^p$c
    },
    grouping_descriptions = list(
        taxon = 'lowest known taxonomic grouping',
        region = 'interior or coastal northwest',
        age_class = 'age delineation for mature and immature trees'
    ),
    parameter_set = parameter_set,
    country = 'USA',
    region = 'WA'
))
