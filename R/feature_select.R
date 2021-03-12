#' Feature selection function
#'
#' @description
#' Performs forward selection of features in the data by starting with an empty model,
#' and iteratively adds features that improve the model's score. The algorithm stops once
#' the decrease of the accuracy from an additional features is bigger than the threshold.
#'
#' @param X_train The training set of the data
#' @param y_train The target of the training set data
#' @param threshold user input threshold used for bounding features selected
#'
#' @return List of best features
#'
#' @examples
#' feature_select(X_train, y_train, threshold=0.05)
feature_select <- function(X_train, y_train, threshold=0.05){

  # exception handling
  if (!any(class(X_train) == "data.frame")) {
    stop("Expected a 'data.frame' object for `data`.")
  }

  if (!any(class(y_train) == "numeric")) {
    stop("Expected a numeric vector for y_train.")
  }

  if (sum(!(dim(X_train))==1) != 2){
    stop("X must be 2 dimensional")
  }

  if (!(NCOL(y_train))==1){
    stop("y must be a 1-d vector")
  }

  if (dim(X_train)[1] != length(y_train)){
    stop("X and y have inconsistent numbers of samples. X:",
         dim(X_train)[1], ", y:", length(y_train))
  }
  if (!(class(threshold) == "numeric")) {
    stop("Threshold must be numeric")
  }
  if (!(length(threshold) == 1)) {
    stop("Threshold must be a single value")
  }

  # initialize variables
  maxper=list()
  initial_features = as.list(colnames(X_train))
  names(initial_features) <- colnames(X_train)
  best_features = list()
  scores = list()
  max_features = length(initial_features)
  previous = 0
  highest= list()

  for (j in 1:max_features){
    remaining_features = initial_features[names(initial_features) %in% names(best_features) == FALSE]
    temp = vector(mode = "list", length = length(remaining_features))
    names(temp) = unlist(remaining_features)

    for (temp_feature in remaining_features){

      select_features = unique(c(best_features, temp_feature))
      names(select_features) = unlist(select_features)
      select_features = as.character(select_features)

      new_df = X_train[,select_features]
      new_df$y_train <- as.vector(y_train)

      n <- names(new_df)
      f <- as.formula(paste("y_train ~", paste(n[!n %in% "y"], collapse = " + ")))
      model = lm(f , data=new_df)

      temp[[temp_feature]] = summary(model)$r.squared

    }
    scoring <- Reduce(max, temp)
    scores[[temp_feature]] <- scoring


    maxperj <- Reduce(max, scores)
    maxper[[j]] <- maxperj

    # stopping criteria
    if (j > 2){
      unlist_prev = unlist(scores)
      previous = unlist_prev[j-1]
      previous = max(previous)

      if ((maxperj - previous / previous) > threshold){ # percentage decrease in R^2 > threshold
        break
      }
    }
    best_features <- c(best_features,names(scores)[which(scores==maxperj)])
    names(best_features) <- unlist(best_features)
  }
  return(names(best_features))
}
