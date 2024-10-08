# allometric changelog

# [3.0.0](https://github.com/brycefrank/allometric/compare/v2.3.0...v3.0.0) (2024-09-22)


### Bug Fixes

* exporting `aggregate_taxa` ([fd2de76](https://github.com/brycefrank/allometric/commit/fd2de7643420b5edb86b415bf9c05abc5d2b3b51))


* Merge pull request #201 from allometric/migrate_processing ([e40c764](https://github.com/brycefrank/allometric/commit/e40c764db2a58782f90b1b71c839e09456436c9e)), closes [#201](https://github.com/brycefrank/allometric/issues/201)


### Features

* adding cli, closes [#186](https://github.com/brycefrank/allometric/issues/186) ([a3ac0b1](https://github.com/brycefrank/allometric/commit/a3ac0b163a836012d928d0089d9d410d28cea479))


### BREAKING CHANGES

* Moving publication processing to models

# [2.3.0](https://github.com/allometric/allometric/compare/v2.2.0...v2.3.0) (2024-02-04)


### Bug Fixes

* removed 'en' from variable definitions, which is a deprecated name for stem density, use 'es' instead ([e88be95](https://github.com/allometric/allometric/commit/e88be958386b8b27c93c7bd90e885c819c1c8b9b))
* removed duplicate 'noa' variable names ([8b5f18a](https://github.com/allometric/allometric/commit/8b5f18ab28357c2e020ee330dbd13dd9e937c93b))


### Features

* added leaf area (rfa), live branch biomass (bbl), and dead branch biomass (bbd) variable names ([d12d5f7](https://github.com/allometric/allometric/commit/d12d5f76a0aa7f5c741aa76bfef2ebbefffc61be))
* added stem + branch biomass variable name (bsr) ([8f85160](https://github.com/allometric/allometric/commit/8f8516049d12766ac489c58fa26e87e3148b260d))

# [2.2.0](https://github.com/allometric/allometric/compare/v2.1.0...v2.2.0) (2024-01-15)


### Bug Fixes

* refactoring rwd and rws, closes [#181](https://github.com/allometric/allometric/issues/181) ([6c7979e](https://github.com/allometric/allometric/commit/6c7979e1365498a9424d4196e7d6344ecde88c15))


### Features

* added mean annual temperature (tlt) and mean annual precipitation (hlp) variable names ([0445628](https://github.com/allometric/allometric/commit/0445628a11713855a59d938612a2dd171406ba5b))
* added the ability to group parameter frames by a taxa ID column ([c3f4121](https://github.com/allometric/allometric/commit/c3f4121552c594a669afec4b7b7eca19e84f987e))
* implemented direct models.RDS downloads, which greatly speed up model installation ([f257a5d](https://github.com/allometric/allometric/commit/f257a5ddc4749467de82fd8a3fde1df643269c11))
* implemented direct models.RDS downloads, which greatly speed up model installation ([edcf173](https://github.com/allometric/allometric/commit/edcf173bb62782525ac7e580211bb272d3052519))
* ingest_models is now exported, which allows users to run local publication and parameter files ([1432808](https://github.com/allometric/allometric/commit/14328089b0cfb7f8c4f57f9ea976bf0c620c3e8d))
* ingest_models is now exported, which allows users to run local publication and parameter files ([fa19690](https://github.com/allometric/allometric/commit/fa19690a7152481f37069aea5246dc6bf563844b))

# [2.2.0](https://github.com/allometric/allometric/compare/v2.1.0...v2.2.0) (2024-01-15)


### Bug Fixes

* refactoring rwd and rws, closes [#181](https://github.com/allometric/allometric/issues/181) ([6c7979e](https://github.com/allometric/allometric/commit/6c7979e1365498a9424d4196e7d6344ecde88c15))


### Features

* added mean annual temperature (tlt) and mean annual precipitation (hlp) variable names ([0445628](https://github.com/allometric/allometric/commit/0445628a11713855a59d938612a2dd171406ba5b))
* added the ability to group parameter frames by a taxa ID column ([c3f4121](https://github.com/allometric/allometric/commit/c3f4121552c594a669afec4b7b7eca19e84f987e))
* implemented direct models.RDS downloads, which greatly speed up model installation ([f257a5d](https://github.com/allometric/allometric/commit/f257a5ddc4749467de82fd8a3fde1df643269c11))
* implemented direct models.RDS downloads, which greatly speed up model installation ([edcf173](https://github.com/allometric/allometric/commit/edcf173bb62782525ac7e580211bb272d3052519))
* ingest_models is now exported, which allows users to run local publication and parameter files ([1432808](https://github.com/allometric/allometric/commit/14328089b0cfb7f8c4f57f9ea976bf0c620c3e8d))
* ingest_models is now exported, which allows users to run local publication and parameter files ([fa19690](https://github.com/allometric/allometric/commit/fa19690a7152481f37069aea5246dc6bf563844b))

# [2.1.0](https://github.com/allometric/allometric/compare/v2.0.0...v2.1.0) (2023-11-07)


### Bug Fixes

* resolving CRAN submission notes ([7bb584e](https://github.com/allometric/allometric/commit/7bb584ec39dcf03c7596e74ca2eb229a7eb9bebf))


### Features

* adding function to check if models are currently installed, closes [#170](https://github.com/allometric/allometric/issues/170) ([8bc84f4](https://github.com/allometric/allometric/commit/8bc84f423d7a9f8e35eaf0b181648b222d3d9417))
* adding unnest_taxa function, closes [#177](https://github.com/allometric/allometric/issues/177) ([1ea66a9](https://github.com/allometric/allometric/commit/1ea66a966043bf63ceeb70d9abb37d80602c3c69))

# [2.0.0](https://github.com/allometric/allometric/compare/v1.4.1...v2.0.0) (2023-10-29)


### Bug Fixes

* models.zip is now removed during installation process ([61cabeb](https://github.com/allometric/allometric/commit/61cabebd1ce084306370aa324032daa782c70eb2))
* nested lists can now be used as arguments to ModelSet and AllometricModel, closes [#167](https://github.com/allometric/allometric/issues/167) ([21e3bd3](https://github.com/allometric/allometric/commit/21e3bd35c4446acb13bda39e0d6a10329f4a8932))


* Rebasing to allometric/models v2 main branch ([72bfcff](https://github.com/allometric/allometric/commit/72bfcff96755fb8dfac4389949442fb36b7da30f))


### Features

* adding equivalence checks for FixedEffectsModel and MixedEffectsModel, closes [#157](https://github.com/allometric/allometric/issues/157) ([5cb295d](https://github.com/allometric/allometric/commit/5cb295d3fe65b8b9359ce049bccd22cad0666e20))
* catching errors in publication files as warnings, which enables installation to proceed even if one or more publication files error, closes [#163](https://github.com/allometric/allometric/issues/163) ([ad67862](https://github.com/allometric/allometric/commit/ad6786218b40e662dc425fb946e58d9deb443203))
* implemented map_publications(), which allows a user to flexibly process publication files ([397246b](https://github.com/allometric/allometric/commit/397246b11af8fdb62b5ae3661f55584cfc95e8d0))
* implementing custom response definitions and associated test. Closes [#86](https://github.com/allometric/allometric/issues/86) ([3bbdc8b](https://github.com/allometric/allometric/commit/3bbdc8b3287ca283dabddb220724dddab1615ba0))


### BREAKING CHANGES

* This commit will require users to reinstall allometric
entirely.

## [1.4.1](https://github.com/brycefrank/allometric/compare/v1.4.0...v1.4.1) (2023-09-20)


### Bug Fixes

* documentation updates for CRAN resubmission ([78938ac](https://github.com/brycefrank/allometric/commit/78938acd11ec64824f0779de2f84f5b8a38c3bbf))

# [1.4.0](https://github.com/allometric/allometric/compare/v1.3.1...v1.4.0) (2023-09-15)


### Bug Fixes

* removing git clone in favor of curl_download for allometric/models, this (may) avoid an issue in CRAN with bad file permissions in the .git directory ([1c36306](https://github.com/allometric/allometric/commit/1c36306426fb686d64d3a7ed962e864bd4f8e4ab))


### Features

* added capability to check local models for installation, check_local_models(). closes [#145](https://github.com/allometric/allometric/issues/145) ([4de906f](https://github.com/allometric/allometric/commit/4de906f26ea3cad5d8ab1f048a984ba731a88b08))
* added topographic and climatic components, closes [#128](https://github.com/allometric/allometric/issues/128) ([9d1b7fb](https://github.com/allometric/allometric/commit/9d1b7fbe63eb61c77d500a7a7549f5ab599a69a9))
* Adding FixedEffectSet summary, restructuring related generics, updates [#136](https://github.com/allometric/allometric/issues/136) ([fa0772f](https://github.com/allometric/allometric/commit/fa0772f6e6007079d8d68383f79f121c5c77f8a1))
* Adding MixedEffectsModel summary, closes [#137](https://github.com/allometric/allometric/issues/137) ([e556541](https://github.com/allometric/allometric/commit/e556541c868d1ca48a66180666b58527e2c83318))
* Adding MixedEffectsSet summary, closes [#136](https://github.com/allometric/allometric/issues/136) ([c27f84d](https://github.com/allometric/allometric/commit/c27f84d35f653d0b52ead57a8345ed911988486a))
* Adding ParametricSet class, closes [#148](https://github.com/allometric/allometric/issues/148) ([49f795c](https://github.com/allometric/allometric/commit/49f795c0e3e2eb4988d4b33547b0e214518cf4d7))
