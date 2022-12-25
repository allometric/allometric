huy_2019_citation <- RefManageR::BibEntry(
    bibtype='article',
    key = 'huy_2019',
    title = 'Taxon-specific modeling systems for improving reliability of tree aboveground biomass and its components estimates in tropical dry dipterocarp forests',
    author = 'Huy, Bao and Tinh, Nguyen Thi and Poudel, Krishna P and Frank, Bryce Michael and Temesgen, Hailemariam',
    journal = 'Forest Ecology and Management',
    volume = 437,
    pages = '156-174',
    year = 2019,
    publisher = 'Eslevier'
)

huy_2019 <- Publication(
    citation = huy_2019_citation,
    shared_descriptors = list(
        country = "VN"
    )
)

bs_huy_2019_1 <- ModelSet(
    response_unit = list(
        bs = as_units('kg')
    ),
    covariate_units = list(
        dsob = as_units('cm'),
        hst = as_units('m'),
        es = as_units('g/cm^3')
    ),
    predict_fn = function(dsob, hs, es, p) {
        p$a_1 * dsob^b_11 * hst^b_12 * es^b_13
    },
    model_descriptions = as_tibble(load_parameter_frame('bs_huy_2019_1'))
)

huy_2019 <- add_set(huy_2019, bs_huy_2019_1)