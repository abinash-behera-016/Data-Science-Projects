#Let's load the necessary packages.
library(xgboost)
library(dplyr)
library(ggplot2)
library(pROC)

#Let's drop ID 
#Now, let's define input and output variables for xgBoost.
output <- redwine_train$quality
input <- redwine_train %>% select(-quality)

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
wine_xgB = xgboost(data = as.matrix(input),
                    label = redwine_train$quality,
                    params = params,
                    nrounds = 1000,
                    verbose = 1)


#Let's look at the SHAP plot to know which variables contribute the most,
xgb.plot.shap(data = as.matrix(input),
              model = wine_xgB,
              top_n = 5)

#Let's create a new numeric matrix by removing the target variable from the test data.
redwine_test1 <- select(redwine_test, -quality)
newdata_matrix = as.matrix(redwine_test1)

#Let's predict for the test data.
wine_xGB_pred = data.frame(Real_Q = redwine_test$quality, 
                            Predicted_Q = predict(wine_xgB, newdata = as.matrix(newdata_matrix), type = 'response'))

#Let's calculate evaluation metrics like RMSE, RMSLE, MAPE.
#rmse
mean((wine_xGB_pred$Real_Q - wine_xGB_pred$Predicted_Q)**2) %>% sqrt() #0.5014642

#Let's calculate RMSLE(Root Mean Squared Logarithmic Error), which a more generalized evaluation metric.
sqrt(mean((log(wine_xGB_pred$Predicted_Q + 1) - log(wine_xGB_pred$Real_Q + 1))^2)) #0.07706298

#Let's calculate MAPE(Mean Absolute Percentage Error)
mean(abs((wine_xGB_pred$Real_Q - wine_xGB_pred$Predicted_Q) / wine_xGB_pred$Real_Q)) #0.06073425