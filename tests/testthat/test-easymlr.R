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
