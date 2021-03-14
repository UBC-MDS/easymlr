library(MASS)
library(tidyverse)
library(rlist)
library(testthat)
attach(Boston)

#' Test whether test_baseline_fun can worked as expected
#'
#' @return None. the function will not throw an error
#'
#' @export
#'
#' @examples
#' test_baseline_fun()
test_baseline_fun <- function() {
  # Setup the toy data
  data(mtcars)
  mtcars$vs <- factor(mtcars$vs)
  x <- mtcars[1:2]
  x_e <- mtcars[1:2][1:20,]
  y_1 <- mtcars[3]
  y_2 <- mtcars[8]

  model_reg <- baseline_fun(x, y_1)
  model_cla <- baseline_fun(x, y_2, type = 'classification')

  test_that("The regression model should use lm, and classification should use glm", {
    expect_equal(model_reg$method, 'lm')
    expect_equal(model_cla$method, 'glm')
  })

  test_that("Each model use the appropiate metrics", {
    expect_true('RMSE' %in% colnames(model_reg$results) & 'Rsquared'  %in% colnames(model_reg$results))
    expect_true('Accuracy' %in% colnames(model_cla$results) & 'Kappa' %in% colnames(model_cla$results))
  })

  test_that("Error raising failed", {
    expect_error(baseline_fun(x, y_2, type = 'classify'), "The type argument should be either regression or classification")
    expect_error(baseline_fun(x, y_1, type = 'classification'), "The logistic regression can only classfiy the object with two levels")
    expect_error(baseline_fun(x_e, y_1), "The number of rows between x and y should be the same")
    expect_error(baseline_fun(x, x), "y should have 1 column only")
    expect_error(baseline_fun(as.list(x), y_1), "X should be a dataframe")
    expect_error(baseline_fun(x, y_1$disp), "y should be a dataframe")
  })

}

test_baseline_fun()

#' Test whether eda_analysis can worked as expected
#'
#' @return
#' @export
#'
#' @examples
#' test_eda_analysis()
test_eda_analysis <- function() {

  # Create toy data set
  ls <- c(1,2,3,4,5)


  # handle exception
  test_that('Check if user provides a data frame', {
    expect_error(eda_analysis(ls))
  })



  test_that('Check attributes', {
    res <- eda_analysis(mtcars)
    expect_true('data_head' %in% names(res))
  })


  test_that('Check attributes', {
    res <- eda_analysis(mtcars)
    expect_true('data_tail' %in% names(res))
  })



  test_that('The output of data_head should be a dataframe', {
    res <- eda_analysis(mtcars)
    expect_true(is.data.frame(res$data_head))
  })


  test_that('The output of function should be a list', {
    res <- eda_analysis(mtcars)
    expect_true(is.list(res))
  })
}

test_eda_analysis()


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
    testthat::expect_error(feature_select(0, y_train, threshold = 0.05), "Expected a 'data.frame' object for X_train")
    testthat::expect_error(feature_select("helloworld", y_train, threshold = 0.05), "Expected a 'data.frame' object for X_train")
    testthat::expect_error(feature_select(c(), y_train, threshold = 0.05), "Expected a 'data.frame' object for X_train")
    testthat::expect_error(feature_select(list(), y_train, threshold = 0.05), "Expected a 'data.frame' object for X_train")
  })

  # test y_train type
  testthat::test_that("y_train is a numeric vector", {
    testthat::expect_error(feature_select(X_train, "helloworld", threshold = 0.05), "Expected a numeric vector for y_train")
    testthat::expect_error(feature_select(X_train, c("helloworld"), threshold = 0.05), "Expected a numeric vector for y_train")
    testthat::expect_error(feature_select(X_train, list(), threshold = 0.05), "Expected a numeric vector for y_train")
    testthat::expect_error(feature_select(X_train, y_3d, threshold = 0.05), "Expected a numeric vector for y_train")
  })

  # test threshold
  testthat::test_that("Incorrect Threshold", {
    testthat::expect_error(feature_select(X_train, y_train, threshold=1.2), "Threshold must be a number between 0 and 1")
    testthat::expect_error(feature_select(X_train, y_train, threshold=-1), "Threshold must be a number between 0 and 1")
    testthat::expect_error(feature_select(X_train, y_train, threshold="hi"), "Threshold must be numeric")
    testthat::expect_error(feature_select(X_train, y_train, threshold = c(0.05, 0.3, 0.1)), "Threshold must be a single value")
    testthat::expect_error(feature_select(X_train, y_train, threshold = list(0.05, 0.3, 0.1)), "Threshold must be numeric")
    testthat::expect_error(feature_select(X_train, y_train, threshold = X_train), "Threshold must be numeric")
  })

  # test dimensions
  testthat::expect_error(feature_select(df_1d, y_train, threshold = 0.05), "X must be 2 dimensional")
  testthat::expect_error(feature_select(X_train, c(1,2,3), threshold = 0.05), "X and y have inconsistent numbers of samples")
}

test_feature_input()
test_feature_select()

#' Test missing data function
#'
#' @description
#'  This test function checks the input and output types, values,
#'  and checks the parameters inputted by the user.
test_miss_data <- function() {

  # Setup the toy data
  x_train <- data.frame('x' = c(400, NA, 300, NA), 'y' = c(24, NA, 30, 560))
  x_test <- data.frame('x' = c(NA, 130, 240, NA), 'y' = c(NA, 300, 450, 100))

  test_that("The mean output of the imputed values are accurate", {
    imputed_data <- miss_data(x_train, x_test, strategy="mean")
    testthat::expect_equal(imputed_data[[1]]$x[2], 350)
    testthat::expect_equal(imputed_data[[2]]$x[1], 185)
  })


  test_that("The median output of the imputed values are accurate", {
    imputed_data <- miss_data(x_train, x_test, strategy="mean")
    testthat::expect_equal(imputed_data[[1]]$y[2], 30)
    testthat::expect_equal(imputed_data[[2]]$y[1], 300)
  })


  test_that("The miss_data function output's objects are lists", {
    imputed_data <- miss_data(x_train, x_test, strategy="mean")
    testthat::expect_equal(typeof(imputed_data[[1]]), 'list')
    testthat::expect_equal(typeof(imputed_data[[2]]), 'list')
  })


  test_that("The input parameters are correct", {
    testthat::expect_error(miss_data(x_train, x_test, strategy = 'mode'), "The strategy should either be mean or median")
    testthat::expect_error(miss_data(x_train, x_test$x, strategy = 'mean'), "The test set must be a dataframe")
    testthat::expect_error(miss_data(x_train, c(0, 1), strategy = 'mean'), "The test set must be a dataframe")
    testthat::expect_error(miss_data(x_train$x, x_test, strategy = 'mean'), "The train set must be a dataframe")
    testthat::expect_error(miss_data(c(0, 1), x_test, strategy = 'mean'), "The train set must be a dataframe")
  })

}

test_miss_data()
