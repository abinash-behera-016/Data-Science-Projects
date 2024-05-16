#Let's load the necessary packages.
library(nnet)
library(pROC)
library(caret)

#We'll create a muliclass logistic model.
dropout_glm = multinom(Target~., data = dropout_train)

summary(dropout_glm)

#Let's predict for test data.
dropout_multi_pred = data.frame(Real_Target = dropout_test$Target, Predicted_Target = predict(dropout_glm, newdata = dropout_test))
View(dropout_multi_pred)


#Let's calculate accuracy. Since, they are of chr type, below simple formula would work.
mean(dropout_multi_pred$Predicted_Target == dropout_multi_pred$Real_Target) #0.7683616
