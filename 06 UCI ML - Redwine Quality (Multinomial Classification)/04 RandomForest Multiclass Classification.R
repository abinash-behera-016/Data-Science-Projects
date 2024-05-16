#Let's load the necessary packages.
library(randomForest)
library(caret)

#We'll treat 'quality' as a discrete category now and perform multiclass prediction.
#Let's convert the output variable to factor.
redwine_train$quality <- factor(redwine_train$quality)
redwine_test$quality <- factor(redwine_test$quality)


#Let's define the control function for training
train_control <- trainControl(
  method = "cv",               # Use cross-validation
  number = 10,                 # Number of folds in K-fold CV
  savePredictions = "final",   # Save predictions for the final model
  summaryFunction = multiClassSummary  # Use multi-class accuracy and other metrics
)


#To create a full grid of mtry (including other parameters produced an error: The tuning parameter grid should have columns mtry)
my_parameters <- expand.grid(mtry = c(1, 2, 3, 4, 5, 6))

# Check the structure of the parameter grid
print(head(my_parameters))

#Now we'll train the model using a random subset of parameters
set.seed(123)
wine_rF <- train(
  quality ~ ., 
  data = redwine_train,
  method = "rf",              # Random forest model
  trControl = train_control,
  tuneGrid = my_parameters)    # Your subset of tuning parameters


#To print the best model and its accuracy
print(wine_rF)
print(wine_rF$results)

#Let's the predict values for the test data.
redwine_rF_pred = data.frame(Real_Q = redwine_test$quality, Predicted_Q = predict(wine_rF, newdata = redwine_test))
View(redwine_rF_pred)

#Accuracy
confusionMatrix(data = redwine_rF_pred$Predicted_Q, reference = redwine_rF_pred$Real_Q) #0.7219