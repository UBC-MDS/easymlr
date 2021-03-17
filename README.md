
<!-- README.md is generated from README.Rmd. Please edit that file -->

# easymlr

<!-- badges: start -->
[![test-coverage](https://github.com/UBC-MDS/easymlr/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/UBC-MDS/easymlr/actions/workflows/test-coverage.yaml)
[![R-CMD-check](https://github.com/UBC-MDS/easymlr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/UBC-MDS/easymlr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

easymlr is an open-source library designed to perform exploratory data
analysis, to help with missing data imputation and to give baseline
models. Also, it assists in feature selection which is a common problem
when undertaking a data science or machine learning analysis. As it’s
name indicates, this function performs all task from eda to helping in
choosing model for machine learning process very easily.

## Installation

You can install the released version of easymlr from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("easymlr")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/easymlr")
```

## Features

This package introduces a data science enthusiast, with little to no
knowledge of machine learning, to the common steps required when
undertaking a Supervised learning analysis. The package contains four
functions that accept a pandas DataFrame. All functions can be used on a
dataset with numerical features. The functions might have their own
required and optional arguments.

-   **eda**: The `eda` function will split the original data into train
    and test dataset and will generate a statistical report such as
    correlation between the variables, number of missing data, class
    imbalance and type of data present in the dataset.

-   **miss\_data**: The `miss_data` function will handle missing
    numerical data in the data frame.

-   **baseline\_fun**: The `baseline_fun` function will give users a
    quick check of the performance of the selected sklearn models
    compared to a baseline model, upon which the model can be improved.

-   **feature\_select**: The `feature_select` function will remove
    redundant features based on the forward selection.

## Relevance to the R Ecosystem

To our knowledge, there is no general-purpose library for performing the
above task together in the R ecosystem.

## Dependencies

-   R 4.0.3

## Usage

| Task                                       | Function                                                                                  |
|--------------------------------------------|-------------------------------------------------------------------------------------------|
| Exploratory data analysis                  | `eda_analysis(df)`                                                                        |
| Numerical data imputation                  | `miss_data(x_train, x_test, strategy="mean")`                                             |
| Compare selected model to a baseline model | `baseline_fun(X_train, y_train, type="regression")` |
| Feature selection to reduce data dimension | `feature_select(X_train, y_train, threshold=0.05)`                                        |

## Example

``` r
library(easymlr)

df <- data.frame('x' = c(400, NA, 300, NA), 'y' = c(24, NA, 30, 560))

- eda <- eda_analysis(df)
- imputed_data <- miss_data(x_train, x_test, strategy="mean")
- results = baseline_fun(X, y, type = 'regression')
- best_features = feature_select(X_train, y_train, threshold=0.05)

```

## Contributors

Development leaders:

    Ifeanyi Anene
    Lara Habashy
    Sakshi Jain
    Zhenrui Yu

## Code of conduct

Hi, please ensure to adhere to the [code of
conduct](https://github.com/UBC-MDS/easymlr/blob/main/CODE_OF_CONDUCT.md)
if you would like to contrtibute to this project.

## Contributors

We welcome and recognize all contributions. You can see a list of
current contributors in the contributors tab. If you would like to
contribute, please view our [contributing
guidelines](https://github.com/UBC-MDS/524_easysklearn/blob/main/CONTRIBUTING.rst)
and get familiar with the [Github
flow](https://blog.programster.org/git-workflows) workflow.
