library(testthat)


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
