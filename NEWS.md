<!-- NEWS.md is maintained by https://cynkra.github.io/fledge, do not edit -->

# allometric 1.2.4 (2023-09-10)

- Same as previous version.


# allometric 1.2.3 (2023-09-09)

- Same as previous version.


# allometric 1.2.2 (2023-09-08)

- Same as previous version.


# allometric 1.2.1.9001 (2023-09-08)

- Same as previous version.


# allometric 1.2.1.9000 (2023-09-08)

- Same as previous version.


# allometric 1.2.1 (2023-09-07)

- Same as previous version.


# allometric 1.2.0.9000 (2023-08-23)

## Documentation

- Improvement to various docstrings in preparation for CRAN.

- Changed documentation theme.


# allometric 1.2.0 (2023-08-17)

- Merge pull request #129 from allometric/model_migration.

Model migration


# allometric 1.1.0.9000 (2023-08-15)

- Same as previous version.


# allometric 1.1.0 (2023-06-24)

## Bug fixes

- Increment models now return the correct model type, closes #117.

## Features

- Adding temesgen_2007, closes #119.

- Adding FVS PN variant crown ratio models, updates #113.

- Adding montero_2020, closes #31.

- Adding larsen_1985, closes #115.

- Adding means_1989, closes #102.

- Adding fvs_2008 wykoff functions, updates #113.


# allometric 1.0.0.9010 (2023-06-24)

- Same as previous version.


# allometric 1.0.0.9009 (2023-06-02)

## Bug fixes

- Parameters and descriptors of ParametricModel are coerced to list before coercing to tibble, allows for use of named vectors. closes #99.

## Features

- Adding fvs PN variant height models, updates #113.

- Adding harrington_1986, closes #111.

- Added a basic boilerplate generator, closes #110.

- Added cochran_1985, closes #104.

## Documentation

- Switching theme to preferably.

- Removing auto-generated model reference pages, related code, and tests closes #112.

- Fixing darkmode logo.


# allometric 1.0.0.9008 (2023-05-27)

## Features

- Adding curtis_1974, closes #106.

- Adding barrett_1978, closes #98.

- Adding curtis_1990, closes #97.

- Adding dahms_1964, closes #96.

## Uncategorized

- Merge branch 'master' of https://github.com/brycefrank/allometric.



# Features

- Adding barrett_1978, closes #98.

- Adding curtis_1990, closes #97.

- Adding dahms_1964, closes #96.


# allometric 1.0.0.9007 (2023-04-01)

- Same as previous version.


# allometric 1.0.0.9006 (2023-02-28)

## Features

- Adding increment and scale flags to variable naming system, closes #72, closes #85.

- Adding edminster_1980, closes #82.

- Adding eng_2012, closes #81.

## Chore

- Refactored volume names to accommodate inside/outside bark, closes #80.

- Adding bark modifier to volume variables, updates #80.

## Documentation

- Added help section to readme.

- Fleshing out mixed-effects models vignette, closes #83.

## Testing

- Refactored volume names in testing suite.


# allometric 1.0.0.9005 (2023-02-14)

## Bug fixes

- Removing units before prediction.

## Features

- Adding automatic unit conversions when covariate units are specified, closes #63.

- Adding krisnawati_2016, closes #75.

- Improved the caching for publications, which will now only run recently updated (or added) publications instead of all publications.

- Adding delcourt_2022, closes #77.

- Adding huynh_2022, closes #76.

## Chore

- Model_specifications must be unique across the non-parameter column names, fixing various pubs that did not comply with this, closes #62.


# allometric 1.0.0.9004 (2023-02-04)

## Features

- Adding ung_2008, closes #73.

- Adding lambert_2005.

- Adding chojnacky_1994.

- Adding hann_1978 volume models for unforked trees, updates #70.

## Documentation

- Updated Variable Naming System vignette.

## Uncategorized

- Merge branch 'master' of https://github.com/brycefrank/allometric.



# allometric 1.0.0.9003 (2023-01-28)

## Bug fixes

- BibOptions are set when constructing reference pages, this avoids fluctuating reference page titles, which was creating a lot of git tracking overhead. closes #69.

## Features

- Adding chittester_1984, closes #67.

- Adding myers_1972, closes #66.

## Chore

- Models are sorted by model_type in the reference index, closes #68.


# allometric 1.0.0.9002 (2023-01-26)

## Features

- Adding chojnacky_1988, closes #64.

- Adding hahn_1984, closes #62.

- Adding scott_1981, closes #61.

- Adding a unit for (merchantable) logs.

## Chore

- Model IDs are now established using the first 8 characters of the.
hash

- Adding age to variable defs and other variable def adjustmenst.


# allometric 1.0.0.9001 (2023-01-23)

## Features

- Adding a unit for (merchantable) logs.

## Chore

- Model IDs are now established using the first 8 characters of the.
hash

- Adding age to variable defs and other variable def adjustmenst.


# allometric 1.0.0.9000 (2023-01-22)

## Features

- Adding model_types as a column to llometric_models, closes #47.

## Chore

- Cleaning up variable_defs functions.

- Adding an issue template for model errors.

## Documentation

- Improving README with biomass category/continent table, closes #58.

## Testing

- Adding tests for new var_defs.


# allometric 1.0.0 (2023-01-21)

## Documentation

- Adding inventory examples, fia_trees dataset.


# allometric 0.1.0 (2023-01-21)

## Documentation

- Adding inventory examples, fia_trees dataset.


# allometric 0.0.1.9003 (2023-01-20)

## Code style

- Styling publication files.

## Testing

- >= 90% coverage, closes #55.

- Adding update_models and update_references tests.


# allometric 0.0.1.9002 (2023-01-19)

## Bug fixes

- Hahn_1991 models parameters were corrected due to a processing error.


# allometric 0.0.1.9001 (2023-01-16)

## Features

- Adding hahn_1991, closes #54.

- Adding uller_2019, closes #46.

## Uncategorized

- Docs: added development version badge to README.


# allometric 0.0.1.9000 (2023-01-15)

- Merge branch 'master' of https://github.com/brycefrank/allometric.
