#Load the necessary packages.
library(xgboost)
library(pROC)


#Let's convert 'symboling' to factor.
automobiles_train$symboling <- factor(automobiles_train$symboling)

#Let's map factor levels to integers starting from 0
symboling_mapping <- as.integer(factor(levels(automobiles_train$symboling))) -1

#Let's encode 'symboling' values with the mapped integers
automobiles_train$symboling_encoded <- symboling_mapping[automobiles_train$symboling]
automobiles_test$symboling_encoded <- symboling_mapping[automobiles_test$symboling]

#Remove the original 'symboling' columns
automobiles_train$symboling <- NULL
automobiles_test$symboling <- NULL

#Now, let's define input and output variables for xgBoost.
output <- automobiles_train$symboling_encoded
input <- automobiles_train%>% select(-symboling_encoded)

# Set objective to multi:softmax for classification into multiple classes
params <- list(
  objective = "multi:softmax",  # or "multi:softprob" for probability prediction
  num_class = 6,  # Number of unique classes in the target variable
  booster = "gbtree",
  eta = 0.01,
  max_depth = 8,
  min_child_weight = 3,
  subsample = 0.8,
  colsample_bytree = 0.8,
  lambda = 3,
  alpha = 0,
  eval_metric = "auc")  # or other multi-class metrics like "merror" or "auc"

#Let's train the sgboost model.
auto_xgB <- xgboost(data = as.matrix(input),
                    label = output,
                    params = params,
                    nrounds = 1000,
                    verbose = 1)


#Let's create a new numeric matrix by removing the target variable from the test data.
newdata_matrix = as.matrix(select(automobiles_test, -symboling_encoded))

# Predict probability scores for test data
predicted_xGB_auto <- predict(auto_xgB, newdata = as.matrix(newdata_matrix), type = 'prob')

#Let's calculate auc scores.
auc(multiclass.roc(automobiles_test$symboling_encoded, predicted_xGB_auto)) #0.9309
