---
title: "Install allometric models from the models repository"
description: "Allometric models are stored in a remote repository located on GitHub located here."
---

Allometric models are stored in a remote repository located on GitHub located [here](https://github.com/allometric/models). The user must install these models themselves using this function. This function downloads the compiled v4 parquet distribution from the models repository and installs it within the allometric package directory. Refer to `load_models()` for information about loading the models dataframe.

## Usage

```r

install_models(redownload = TRUE, verbose = TRUE)
```

## Arguments

- **redownload** — If `TRUE`, models are re-downloaded from the remote repository.

- **verbose** — If `TRUE`, print verbose messages as models are installed.

## Value

No return value, installs models into the package directory.

