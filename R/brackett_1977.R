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

ParametricFamily(
    response_unit = list(
        vsa = units('ft3')
    ),
    covariate_units = list(
        dsob = units('in'),
        hst  = units('ft')
    ),
    parameter_set = load_local('vsa_bracket_1977.csv')
)