#Let's load the necessary packages.
library(car)

#Now we'll treat the target variable 'quality' as a continuous numeric column and create a simple linear regression model.
fit_redwine = lm(quality ~., data = redwine_train)

#Let's filter variables based on vif values.
sort(vif(fit_redwine), decreasing = T) [1:5] #All vif values are under 10.

#Let's now predict for the test data.
redwine_lm_pred = data.frame(Real_Q = redwine_test$quality, Predcited_Q = predict(fit_redwine, newdata = redwine_test))
View(redwine_lm_pred)

#Let's calculate rmse score.
RMSE(redwine_lm_pred$Predcited_Q, redwine_lm_pred$Real_Q) #0.6282276