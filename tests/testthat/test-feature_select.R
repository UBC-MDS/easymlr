library(MASS)
library(tidyverse)
library(rlist)
library(testthat)
attach(Boston)

#' Test feature selection output
#'
#' @description
#'  This test imports the Boston dataset which has 13 features. Applying the forward 
#'  selection algorithm for feature selection with the default
#'  threshold of 0.05, the function selects the best features.
test_feature_select <- function(){
  
  data <- Boston
  X_train = data %>% select(-medv)
  y_train = data %>% pull(medv)
  
  # set seed for reproducible output
  set.seed(1230)
  
  threshold = 0.05
  best_features <- feature_select(X_train, y_train, threshold = threshold)
  
  testthat::expect_setequal(best_features[1], "lstat")
  testthat::expect_true(length(best_features)<= length(as.list(colnames(X_train))))
  testthat::expect_true(is.vector(best_features))
  testthat::expect_true(is.character(best_features))
  testthat::expect_true(is.character(best_features[1]))
  testthat::expect_true(class(best_features[1]) == "character")
  testthat::expect_true(is.numeric(threshold))
  testthat::expect_true(class(threshold) == "numeric")
  testthat::expect_true(length(threshold) == 1)
}

#' Test feature selection input
#'
#' @description
#'  This test function checks the input types, classes, and dimensions
#'  and checks exception handling 
test_feature_input <- function(){
  data <- Boston
  X_train = data %>% select(-medv)
  y_train = data %>% pull(medv)
  df_1d <- data.frame(y_train)
  
  # test X_train type
  testthat::test_that("X_train is a data.frame", {
    testthat::expect_error(feature_select(0, y_train, threshold = 0.05), "data.frame")
    testthat::expect_error(feature_select("nonsense", y_train, threshold = 0.05), "data.frame")
    testthat::expect_error(feature_select(c(), y_train, threshold = 0.05), "data.frame")
    testthat::expect_error(feature_select(list(), y_train, threshold = 0.05), "data.frame")
  })
  
  # test y_train type
  testthat::test_that("y_train is a numeric vector", {
    testthat::expect_error(feature_select(X_train, "hi", threshold = 0.05), "vector")
    testthat::expect_error(feature_select(X_train, c("hi"), threshold = 0.05), "vector")
    testthat::expect_error(feature_select(X_train, list(), threshold = 0.05), "vector")
    testthat::expect_error(feature_select(X_train, y_3d, threshold = 0.05), "Expected a numeric vector for y_train.") 
  })
  
  # test dimensions 
  testthat::expect_error(feature_select(df_1d, y_train, threshold = 0.05), "X must be 2 dimensional")
  testthat::expect_error(feature_select(X_train, c(1,2,3), threshold = 0.05), "X and y have inconsistent numbers of samples.")
}