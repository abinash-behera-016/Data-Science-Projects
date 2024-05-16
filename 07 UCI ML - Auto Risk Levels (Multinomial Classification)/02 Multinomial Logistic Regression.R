#Load the necessary libraries
library(nnet)
library(caret)
library(pROC)

# Fit the multinomial logistic regression model
log_fit_auto = multinom(symboling ~ ., data = automobiles_train)

# Model simplification using AIC
log_fit_default = step(log_fit_auto)

# Summarize the model
summary(log_fit_auto)

# Predict on test data
glm_predict_auto = predict(log_fit_auto, newdata = automobiles_test, type = "probs")

# We would need to compute AUC for each class.
auc_scores <- sapply(colnames(glm_predict_auto), function(class) {
  # Convert class from character to numeric
  class_numeric <- as.numeric(class)

  # Create a binary response
  actual_binary <- ifelse(automobiles_test$symboling == class_numeric, 1, 0)

  # Check if there are at least two levels in actual_binary
  if (length(unique(actual_binary)) == 2) {
    pred_prob <- glm_predict_auto[, class]
    roc_curve <- roc(response = actual_binary, predictor = pred_prob)
    auc(roc_curve)
  } else {
    NA  # Return NA if not two levels, to avoid error and indicate issue
  }
})

auc_scores


# Print the average AUC
print(mean(auc_scores, na.rm =T)) #0.890381
