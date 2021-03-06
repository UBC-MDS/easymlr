#' Feature selection function
#'
#' @description
#' Performs forward selection of features in the data by starting with an empty model,
#' and iteratively adds features that improve the model's score. The algorithm stops once 
#' the increase of the accuracy from an additional features is smaller than the threshold.
#'
#' @param X_train The training set of the data
#' @param y_train The target of the data
#' @param threshold user input threshold used for stopping criteria
#'
#' @return List of best features
#'
#' @examples
#' feature_select(X_train, y_train, threshold=0.05)
feature_select <- function(X_train, y_train, threshold=0.05){
  
}