% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eda_analysis.R
\name{eda_analysis}
\alias{eda_analysis}
\title{exploratory_data_analysis}
\usage{
eda_analysis(df)
}
\arguments{
\item{df}{The features of the training set}
}
\value{
a list
}
\description{
splits the data into train and test dataframe, provides statistical summary of the variables for a dataframe. Additionally, the function provides a correlation metric of each numeric variable.
}
\examples{
res <- eda_analysis(mtcars)
head <- res$data_head
summary <- res$data_summary
}
