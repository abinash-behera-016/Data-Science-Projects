# Load necessary libraries
library(nnet)
library(caret)
library(pROC)

# Fit the multinomial logistic regression model
log_fit_glass = multinom(Type_of_glass ~ ., data = glass_train)

#To drop variables based on AIC values,
log_fit_glass = step(log_fit_glass)

#Let's look at the model.
summary(log_fit_glass)

#Let's predict on the test data.
glass_multi_pred = data.frame(Real_glass_type = glass_test$Type_of_glass, 
                            Predcited_glass_type = predict(log_fit_glass, newdata = glass_test))

View(glass_multi_pred)

#Let's calculate accuracy.
confusionMatrix(glass_multi_pred$Predcited_glass_type, glass_multi_pred$Real_glass_type) #1
