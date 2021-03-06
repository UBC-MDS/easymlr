#'  Handle missing data in a data frame.
#'
#'  Impute missing values with the strategy (mean, median) selected by the user.
#'
#' @param x_train The train set dataframe with missing values in it.
#' @param x_test The test set DataFrame with missing values in it.
#' @param strategy The imputation strategy as a string
#'
#' @return x_train and x_test dataframe without any missing values.
#' @export
#'
#' @examples
#' x_train <- data.frame('x' = c(400, NA, 330, NA), 'y' = c(24, NA, 30, 560))
#' x_test <- data.frame('x' = c(NA, 130, 240, NA), 'y' = c(NA, 300, 450, 100))
#' miss_data(x_train, x_test, 'mean')
miss_data <- function(x_train, x_test, strategy) {

}
