#Let's load the necessary packages.
library(xgboost)
library(caret)

#Now, let's define input and output variables for xgBoost.
output <- hprice_train_practice$SalePrice
input <- hprice_train_practice %>% select(-SalePrice)

#Let's set hyper parameters.
params <- list(
  objective = "reg:squarederror",  # Regression objective
  booster = "gbtree",
  eta = 0.03,
  max_depth = 5,
  min_child_weight = 2,
  subsample = 0.7,
  colsample_bytree = 0.7,
  lambda = 1,
  alpha = 0.1,
  eval_metric = "rmse")


#Let's build the model now.
hprice_practice_xGB = xgboost(data = as.matrix(input),
                              label = hprice_train_practice$SalePrice,
                              params = params,
                              nrounds = 3500,
                              verbose = 1)


#Let's look at the SHAP plot to know which variables contribute the most,
xgb.plot.shap(data = as.matrix(input),
              model = loans_xgB,
              top_n = 5)

#Let's create a new numeric validation matrix by removing the target variable from the test data.
hprice_val <- select(hprice_val_practice, -SalePrice)
newdata_matrix = as.matrix(hprice_val)

#Let's predict for the test data.
hprice_val_xGB_pred = data.frame(Real_Price = hprice_val_practice$SalePrice, 
                                 Predicted_Price = predict(hprice_practice_xGB, newdata = as.matrix(newdata_matrix), type = 'response'))

#Let's calculate evaluation metrics like RMSE, RMSLE, MAPE.
#rmse
mean((hprice_val_xGB_pred$Real_Price - hprice_val_xGB_pred$Predicted_Price)**2) %>% sqrt()

#Let's calculate RMSLE(Root Mean Squared Logarithmic Error), which a more generalized evaluation metric.
sqrt(mean((log(hprice_val_xGB_pred$Predicted_Price + 1) - log(hprice_val_xGB_pred$Real_Price + 1))^2)) #0.1287041

#Let's calculate MAPE(Mean Absolute Percentage Error)
mean(abs((hprice_val_xGB_pred$Real_Price - hprice_val_xGB_pred$Predicted_Price) / hprice_val_xGB_pred$Real_Price)) #0.08583142





#Let's now build the model on the entire train data.
output <- hprice_train$SalePrice
input <- hprice_train %>% select(-SalePrice) %>% select(-Id)

#Let's set hyper parameters.
params <- list(
  objective = "reg:squarederror",  # Regression objective
  booster = "gbtree",
  eta = 0.03,
  max_depth = 5,
  min_child_weight = 2,
  subsample = 0.7,
  colsample_bytree = 0.7,
  lambda = 1,
  alpha = 0.1,
  eval_metric = "rmse")


#Let's build the model now.
hprice_xGB = xgboost(data = as.matrix(input),
                              label = output,
                              params = params,
                              nrounds = 3500,
                              verbose = 1)


#Let's look at the SHAP plot to know which variables contribute the most,
xgb.plot.shap(data = as.matrix(input),
              model = hprice_xGB,
              top_n = 5)

#Let's create a new numeric validation matrix by removing the target variable from the test data.
newdata_matrix = as.matrix(hprice_test)

#Before predicting, we have to make sure that both train and test dataset have the same columns and in the same order.
#First let's bring the SalePrice column to 1st position.
target_col_index <- which(colnames(hprice_train) == "SalePrice")
hprice_train <- hprice_train[, c(target_col_index, setdiff(1:ncol(hprice_train), target_col_index))]

#We'll align the test columns with the object which will be used to build models, since it doesn't contain Id, test data wont.
hprice_test_id = data.frame(Id = hprice_test$Id) #Saving it in another object

#Now we can safely align the column order of train and test data.
hprice_test <- hprice_test[, colnames(input)]

#To verify alignment,
identical(colnames(input), colnames(hprice_test))

#Let's predict for the test data.
hprice_xGB_pred = data.frame(Id = hprice_test_id$Id, 
                             SalePrice = predict(hprice_xGB, newdata = newdata_matrix, type = 'response'))

View(hprice_xGB_pred)

#Let's export the prediction to csv.
write.csv(hprice_xGB_pred, "submission_housing_price_xGB.csv", row.names = F)