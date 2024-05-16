#Load rhe necessary packages
library(randomForest)
library(xgboost)
library(dplyr)
library(ggplot2)
library(cvTools)
library(xgboost)
library(randomForest)
library(car)
library(caret)
library(fastDummies)
library(pROC)
library(tree)

View(loans_train)
#Let's build the linear regression model.
loans_fit = lm(Interest.Rate ~.-ID -Amount.Requested, data = loans_train)
sort(vif(loans_fit), decreasing = T) [1:5]

#Let's filter out variables on AIC values.
loans_fit = stats::step(loans_fit)

#The model is ready let's predict on the test data.
loans_lm_pred = data.frame(Real_IR = loans_test$Interest.Rate, Predicted_IR = predict(loans_fit, newdata = loans_test))

#Let's calculate evaluation metrics like RMSE, RMSLE, MAPE.
#rmse
mean((loans_lm_pred$Real_IR - loans_lm_pred$Predicted_IR)**2) %>% sqrt() #2.084541

#Let's calculate RMSLE(Root Mean Squared Logarithmic Error), which a more generalized evaluation metric.
sqrt(mean((log(loans_lm_pred$Predicted_IR + 1) - log(loans_lm_pred$Real_IR + 1))^2)) #0.162462

#Let's calculate MAPE(Mean Absolute Percentage Error)
mean(abs((loans_lm_pred$Real_IR - loans_lm_pred$Predicted_IR) / loans_lm_pred$Real_IR)) * 100 #13.8829