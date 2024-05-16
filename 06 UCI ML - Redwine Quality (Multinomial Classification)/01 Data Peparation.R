#Load the necessary packages
library(randomForest)
library(xgboost)
library(dplyr)
library(ggplot2)
library(cvTools)
library(xgboost)
library(randomForest)
library(car)
library(caret)
library(createDummies)
library(pROC)
library(tree)

#We'll be using the winequality_red dataset imported as 'redwine' to predict the variable quality.
table(redwine$quality) #has interger values ranging from 3 to 8. Should be treated as multi-class classification problem.

#Let's check for NAs in each column.
sapply(redwine, function(x) sum(is.na(x))) #No NAs

#Every column is already numeric so this data doesn't need any preparation.
#Let's split the data into test nd train.
set.seed(66)
s = sample(1:nrow(redwine), 0.8*nrow(redwine))
redwine_train = redwine[s, ]
redwine_test = redwine[-s, ]