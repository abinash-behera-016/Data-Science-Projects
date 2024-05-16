#Let's load the neeessary packages.
library(neuralnet)
library(dplyr)
library(pROC)


#Let's build the model.
formula <- Y ~ .  # Assuming all other columns in the dataset are input features

# Train the neural network model
nn_model <- neuralnet(
  formula,
  data = census_train,
  hidden = c(10),  # Number of neurons in the hidden layer(s)
  linear.output = FALSE,  # Set to TRUE if you want a regression model
  threshold = 0.01,  # Threshold for the improvement of the error function
  stepmax = 1e5  # Maximum number of steps for training
)

print(nn_model)


#Let's make predictions on the test data.
census_NN_pred <- data.frame(Real_Y = census_test$Y, Predicted_Y = predict(nn_model, census_test))

#Let's calculate the auc score.
auc(roc(census_NN_pred$Real_Y, census_NN_pred$Predicted_Y)) #0.5921


#Let's create a set of possible cut-offs between 0.001 to 0.999, with an increment of 0.001 in every step.
#This should generate 1000 possible values of cutoffs.
cutoffs = seq(0.001, 0.999, by = 0.001)

#We create a for loop to create a dataframe having TP, TN, FP, FN values for each cutoff value from 0.001 to 0.0.999.
cutoff_census_NN <- data.frame(cutoff = numeric(),
                              TP_sum = integer(),
                              TN_sum = integer(),
                              FP_sum = integer(),
                              FN_sum = integer(),
                              stringsAsFactors = FALSE
)
cutoff_values = seq(0.001, 0.999, by = 0.001)
for (cutoff in cutoff_values) {
  temporaray <- data.frame(
    real = census_NN_pred$Real_Y,
    predicted = as.numeric(census_NN_pred$Predicted_Y > cutoff)
  )
  temporaray <-temporaray %>%  mutate( TP = ifelse(real == 1 & predicted == 1, 1, 0),
                                       FP = ifelse(real == 0 & predicted == 1, 1, 0),
                                       TN = ifelse(real == 0 & predicted == 0, 1, 0),
                                       FN = ifelse(real == 1 & predicted == 0, 1, 0))
  sums = temporaray %>% summarise(
    TP_sum = sum(TP),
    TN_sum = sum(TN),
    FP_sum = sum(FP),
    FN_sum = sum(FN)
  )
  cutoff_census_NN <- bind_rows(cutoff_census_NN, data.frame(cutoff = cutoff, sums))
}

#Let's give the columns a much cleaner names.
cutoff_census_NN = cutoff_census_NN %>% rename("TP" = "TP_sum",
                                        "TN" = "TN_sum",
                                        "FP" = "FP_sum",
                                        "FN" = "FN_sum")
#Let's calculate Accuracy, Sn, Sp, Distance, KS, M for each cutoff and add them to cutoff_data.
cutoff_census_NN = cutoff_census_NN %>% mutate(P = TP + FN,
                                     N = TN + FP,
                                     Accuracy = (TP+TN)/(P+N),
                                     Sn = TP/P,
                                     Sp = TN/N,
                                     Distance = sqrt((1-Sn)^2+(1-Sp)^2),
                                     KS = (TP/P) - (FP/N),
                                     M = ((9*FN)+(0.6*FP))/(1.9*(P+N)))

#Let's find the cutoff value for which,
#(i) Distance in minimum, and the minimum Distance
cutoff_census_NN$cutoff[which.min(cutoff_census_NN$Distance)] [1]
min(cutoff_census_NN$Distance)

#(ii) Accuracy is maximum, and the maximum Accuracy
cutoff_census_NN$cutoff[which.max(cutoff_census_NN$Accuracy)] [1]
max(cutoff_census_NN$Accuracy) #0.799478

#(iii) KS is maximum, and the maximum KS
cutoff_census_NN$cutoff[which.max(cutoff_census_NN$KS)] [1]
max(cutoff_census_NN$KS)

#(iv) M is minimum, and the minimum M
cutoff_census_NN$cutoff[which.min(cutoff_census_NN$M)] [1]
min(cutoff_census_NN$M)