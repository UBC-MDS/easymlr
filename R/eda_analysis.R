#' exploratory_data_analysis
#'
#' @description
#' splits the data into train and test dataframe, provides statistical summary of the variables for a dataframe. Additionally, the function provides a correlation metric of each numeric variable.
#'
#' @param df The features of the training set
#'
#'
#' @return a list
#' @export
#'
#' @examples

eda_analysis <- function(df) {
  if(class(df) != 'data.frame'){
    stop('df should be a dataframe')}


  #splitting data
  smp_size <- floor(0.75 * nrow(df))
  set.seed(123)
  train_data <- sample(seq_len(nrow(df)), size = smp_size)
  train <- df[train_data, ]
  test <- df[-train_data, ]

  #data stats
  data_head<- head(train)
  data_tail<- tail(train)
  data_type<- capture.output(str(train))
  out2 <- paste(data_type, collapse="\n")
  data_summary<- summary(train)


  #column filtering for correlation matrix
  nums <- unlist(lapply(train, is.numeric))
  Data_filtered = train[,nums]
  data_correlation<- cor(Data_filtered)



  eda<- list(
    data_head = head(train),
    data_tail = tail(train),
    type = out2,
    data_summary= summary(train),
    correlation= data_correlation

  )


  return(eda)
}
