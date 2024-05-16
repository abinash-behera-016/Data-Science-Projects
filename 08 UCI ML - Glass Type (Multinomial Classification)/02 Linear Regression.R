#Load the necessary packages.
library(ggplot2)
library(caret)

#Let's first build a simple linear regression model first.
fit_glass = lm(Type_of_glass~. - ID, data = glass_train)

#Let's filter variables based on vif values.
sort(vif(fit_glass), decreasing = T) [1:5]

#Removing 'Magnesium' with very high vif value,
fit_glass = lm(Type_of_glass~. -ID -Magnesium, data = glass_train)

#Filtering variables based on AIC values,
fit_glass = step(fit_glass)

#Let's predict for the test data.
glass_lm_pred = data.frame(Real_glass_type = glass_test$Type_of_glass, Predicted_glass_type = predict(fit_glass, newdata = glass_test))

#Let's check the RMSE value
RMSE(glass_lm_pred$Predicted_glass_type, glass_lm_pred$Real_glass_type) #1.044806
