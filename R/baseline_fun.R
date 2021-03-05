
#' Baseline function
#'
#' @description
#' Gives the scoring metrics of LinearRegression or LogisticRegression.
#'
#' @param X The features of the training set
#' @param y The target of the training set
#' @param type What kind of supervised machine learning to use, regression or classification
#' @param metric What kind of score metrics to use, possible values are "RMSE" and "Rsquared" for regression and "Accuracy" and "Kappa" for classification.
#'
#' @return The validation score by 5-fold cross validation for the chosen model.
#'
#' @examples
#' baseline_fun(X, y, type = 'regression', metric='RMSE')
baseline_fun <- function(X, y, type = 'regression', metric){

}
