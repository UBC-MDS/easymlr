
<!-- README.md is generated from README.Rmd. Please edit that file -->

# easymlr

<!-- badges: start -->

<!-- badges: end -->

easymlr is an open-source library designed to perform exploratory data analysis, to help with missing data imputation and to give baseline models. Also, it assists in feature selection which is a common problem when undertaking a data science or machine learning analysis.


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

This package contains four functions that accept a pandas DataFrame. All functions can be used on a dataset with numerical and categorical features. Each function will have it's own required and optional arguments.

- eda: EDA data analysis will split the original data into train and test dataset and will generate a statistical report such as correlation between the variables, number of missing data, class imbalance and type of data present in the dataset.

- Data imputation: It will handle missing data in the data frame.

- Baseline Function: Baseline function will give users a quick check of the performance of the selected sklearn models as a baseline for further model training.

- Feature selection: This will remove redundant features based on the forward selection.

## Relevance to the R Ecosystem
To our knowledge, there is no general-purpose library for performing the above task together in the Python ecosystem.

## Dependencies

-   TODO

## Usage

-   TODO

## Documentation

## Contributors

Development leaders:

- Ifeanyi Anene
- Lara Habashy
- Sakshi Jain
- Zhenrui Yu

We welcome and recognize all contributions. You can see a list of current contributors in the contributors tab. If you would like to contribute, please view our contributing guidelines and get familiar with the Github flow workflow.

## Credits
