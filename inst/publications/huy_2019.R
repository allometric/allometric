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
    citation = huy_2019_citation
)

bs_huy_2019_1 <- ModelSet(
    response_unit = list(
        bs = as_units('kg')
    ),
    covariate_units = list(
        dsob = as_units('cm'),
        hs = as_units('m'),
        es = as_units('g/cm^3')
    ),
    predict_fn = function(p, x) {
        p$a1 * x$dsob^b11 * x$hs^b12 * x$es^b13
    },
    model_descriptions =  load_parameter_frame('bs_huy_2019_1'),
    common_descriptors = list(
        country = 'VN'
    )
)

huy_2019 <- add_set(huy_2019, bs_huy_2019_1)