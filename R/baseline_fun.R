
#' Baseline function
#'
#' @description
#' Gives the scoring metrics of LinearRegression or LogisticRegression.
#'
#' @param X The features of the training set
#' @param y The target of the training set
#' @param type What kind of supervised machine learning to use, regression or classification
#'
#' @return The list of the result of 5-fold cross validation for the chosen model.
#' @export
#'
#' @examples
#' data(mtcars)
#' mtcars$vs <- factor(mtcars$vs)
#' x <- mtcars[1:2]
#' y <- mtcars[8]
#' model_cla <- baseline_fun(x, y, type = 'classification')


baseline_fun <- function(X, y, type = 'regression') {
  if(class(X) != 'data.frame'){
    stop('X should be a dataframe')}

  if(class(y) != 'data.frame'){
    stop('y should be a dataframe')}

  if(ncol(y) != 1){
    stop('y should have 1 column only')}

  if(nrow(X) != nrow(y)){
    stop('The number of rows between x and y should be the same')}

  if(type %in% c('regression', 'classification') == FALSE){
    stop('The type argument should be either regression or classification')}

  if(type == 'classification'){
    if(nrow(unique(y)) != 2){
      stop('The logistic regression can only classfiy the object with two levels')
    }
  }

  names(y) <- "target"
  train_set <- cbind(X, y)

  if (type == 'regression') {
    train_control <- caret::trainControl(method = 'cv', number = 5)
    model <- caret::train(
      target ~ .,
      data = train_set,
      trControl = train_control,
      method = 'lm',
      na.action = na.pass
    )
  }

  if (type == 'classification') {
    train_control <- caret::trainControl(method = 'cv', number = 5)
    model <- caret::train(
      target ~ .,
      data = train_set,
      trControl = train_control,
      method = 'glm',
      na.action = na.pass
    )
  }
  return(model)
}
