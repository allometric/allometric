# allometric changelog

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
