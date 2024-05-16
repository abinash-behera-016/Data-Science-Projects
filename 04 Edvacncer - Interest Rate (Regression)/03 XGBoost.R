#Let's load the necessary packages.
library(xgboost)
library(dplyr)
library(ggplot2)
library(pROC)

#Let's drop ID 
#Now, let's define input and output variables for xgBoost.
output <- loans_train$Interest.Rate
input <- loans_train %>% select(-Interest.Rate)

#Let's set hyper parameters.
params <- list(
  objective = "reg:squarederror",  # Regression objective
  booster = "gbtree",
  eta = 0.03,
  max_depth = 6,
  min_child_weight = 2,
  subsample = 0.7,
  colsample_bytree = 0.7,
  lambda = 1,
  alpha = 0.1,
  eval_metric = "rmse")


#Let's build the model now.
loans_xgB = xgboost(data = as.matrix(input),
                      label = loans_train$Interest.Rate,
                      params = params,
                      nrounds = 1000,
                      verbose = 1)


#Let's look at the SHAP plot to know which variables contribute the most,
xgb.plot.shap(data = as.matrix(input),
              model = loans_xgB,
              top_n = 5)

#Let's create a new numeric matrix by removing the target variable from the test data.
loans_test1 <- select(loans_test, -Interest.Rate)
newdata_matrix = as.matrix(loans_test1)

#Let's predict for the test data.
loans_xGB_pred = data.frame(Real_IR = loans_test$Interest.Rate, 
                            Predicted_IR = predict(loans_xgB, newdata = as.matrix(newdata_matrix), type = 'response'))

#Let's calculate evaluation metrics like RMSE, RMSLE, MAPE.
#rmse
mean((loans_xGB_pred$Real_IR - loans_xGB_pred$Predicted_IR)**2) %>% sqrt() #1.767279

#Let's calculate RMSLE(Root Mean Squared Logarithmic Error), which a more generalized evaluation metric.
sqrt(mean((log(loans_xGB_pred$Predicted_IR + 1) - log(loans_xGB_pred$Real_IR + 1))^2)) #0.1304692

#Let's calculate MAPE(Mean Absolute Percentage Error)
mean(abs((loans_xGB_pred$Real_IR - loans_xGB_pred$Predicted_IR) / loans_xGB_pred$Real_IR)) #0.1079494