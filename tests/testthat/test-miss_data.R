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
