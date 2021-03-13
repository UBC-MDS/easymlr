#'  Handle missing data in a data frame.
#'
#'  Impute missing values with the strategy (mean, median) selected by the user.
#'
#' @param x_train The train set dataframe with missing values in it.
#' @param x_test The test set DataFrame with missing values in it.
#' @param strategy The imputation strategy as a string
#'
#' @return list containing the x_train and x_test dataframes without any missing values.
#' @export
#'
#' @examples
#' x_train <- data.frame('x' = c(400, NA, 330, NA), 'y' = c(24, NA, 30, 560))
#' x_test <- data.frame('x' = c(NA, 130, 240, NA), 'y' = c(NA, 300, 450, 100))
#' x_train_imputed <- miss_data(x_train, x_test, 'mean')[1]
#' x_test_imputed <- miss_data(x_train, x_test, 'mean')[2]
miss_data <- function(x_train, x_test, strategy) {
  if (!is.data.frame(x_train) | !is_tibble(x_train))
    stop("The training set must be either a dataframe or a tibble")

  if (!is.data.frame(x_test) | !is_tibble(x_test))
    stop("The test set must be either a dataframe or a tibble")

  if (!is.character(strategy))
    stop("The imputation strategy must be a string.")

  if (strategy != "mean" && strategy != "median")
    stop("The Imputation strategies are only mean or median")


  if (strategy == "median") {
    x_train <- x_train %>%
      dplyr::mutate_all(~ifelse(is.na(.), stats::median(., na.rm = TRUE), .)) %>%
      round(5)
    x_test <- x_test %>%
      dplyr::mutate_all(~ifelse(is.na(.), stats::median(., na.rm = TRUE), .)) %>%
      round(5)
  }
  else {
    x_train <- x_train %>%
      dplyr::mutate_all(~ifelse(is.na(.), mean(., na.rm = TRUE), .)) %>%
      round(5)
    x_test <- x_test %>%
      dplyr::mutate_all(~ifelse(is.na(.), mean(., na.rm = TRUE), .)) %>%
      round(5)
  }
  imp_datasets_list <- list(x_train, x_test)
  return(imp_datasets_list)
}
