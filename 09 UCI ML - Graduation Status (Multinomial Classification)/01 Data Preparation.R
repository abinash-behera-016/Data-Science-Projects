#Let's load the necessary packages.
library(dplyr)
library(createDummies)

#We'll use student_dropout data to predict the variable 'Target'.
table(student_dropout$Target)

#Let's look the column names and data types.
glimpse(student_dropout)

#All the predictor variables are of numerical type except the target variable.
#Let's check for NAs.
sapply(student_dropout, function(x) sum(is.na(x))) #No NAs

#Let's split the data into train and test data.
set.seed(99)
s = sample(1:nrow(student_dropout), 0.8*nrow(student_dropout))
dropout_train = student_dropout[s, ]
dropout_test = student_dropout[-s, ]
