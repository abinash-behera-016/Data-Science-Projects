#Let's load the necessary packages for data preparation.
library(dplyr)
library(createDummies)

#We'll use the glass dataset to predict the target variable Type_of_glass.
glimpse(glass)

#All the columns are of numeric type and need no further preparation.
#Let's check for NAs.
sapply(glass, function(x) sum(is.na(x))) #No NAs

#Let's split the dataset into train and test data.
set.seed(88)
s = sample(1:nrow(glass), 0.8*nrow(glass))
glass_train = glass[s, ]
glass_test = glass[-s, ]

glass$Type_of_glass <- factor(glass$Type_of_glass)
