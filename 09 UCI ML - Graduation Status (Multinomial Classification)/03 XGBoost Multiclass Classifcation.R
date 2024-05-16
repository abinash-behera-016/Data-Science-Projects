#Let's load the necessary packages.
library(xgboost)
library(caret)

#XGBoost requires the target variable, in case of multi-class classification problem, to be of numeric levels starting from 0.
#Thus, we'll do exactly that to student_dropout data and then split it to train and test data.
student_dropout = student_dropout %>% mutate(Target_fct = as.integer(factor(Target)) - 1) %>% select(-Target)


#Let's split the data into train and test.
set.seed(99)
s = sample(1:nrow(student_dropout), 0.8*nrow(student_dropout))
dropout_train = student_dropout[s, ]
dropout_test = student_dropout[-s, ]


#Now, let's define input and output variables for xgBoost.
output <- dropout_train$Target_fct
input <- dropout_train%>% select(-Target_fct)


# Set objective to multi:softmax for classification into multiple classes
params <- list(
  objective = "multi:softmax",
  num_class = length(unique(dropout_train$Target_fct)),  #Update to match the number of unique classes in your target variable
  booster = "gbtree",
  eta = 0.05,
  max_depth = 12,
  min_child_weight = 3,
  subsample = 0.6,
  colsample_bytree = 0.9,
  lambda = 3,
  alpha = 0,
  eval_metric = "auc") # or other multi-class metrics like "merror" or "auc"

#Let's train the xgboost model.
dropout_xgB <- xgboost(data = as.matrix(input),
                    label = output,
                    params = params,
                    nrounds = 1000,
                    verbose = 1)


#Let's create a new numeric matrix by removing the target variable from the test data.
newdata_matrix = as.matrix(select(dropout_test, -Target_fct))

# Predict probability scores for test data
predicted_xGB_dropout = data.frame(Real = dropout_test$Target_fct,
                                   Predicted = predict(dropout_xgB, newdata = as.matrix(newdata_matrix)))

#Let's calculate auc scores.
auc(multiclass.roc(predicted_xGB_dropout$Real, predicted_xGB_dropout$Predicted)) #0.828