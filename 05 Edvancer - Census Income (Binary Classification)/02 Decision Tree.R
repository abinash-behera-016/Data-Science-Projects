#Let's load the necessary packages
library(rpart)
library(rpart.plot)
library(tree)
library(pROC)

#Let's first define hyper parameter values.
dt_control <- rpart.control(maxdepth = 5, minsplit = 10, minbucket = 5, splitrule = "gini")

#Let's build the model on the test data.
census_tree = rpart(Y ~. , data = census_train, control = dt_control)

#Let's visualize the tree.
rpart.plot(census_tree)

#Let's predict the target variable Y on test data.
census_Dtree_pred = data.frame(Real_Y = census_test$Y, Predicted_Y = predict(census_tree, newdata = census_test))
View(census_Dtree_pred)

#Let's calculate the auc score.
auc(roc(census_Dtree_pred$Real_Y, census_Dtree_pred$Predicted_Y)) #0.8614

#Let's calculate evaluation metrics for different cut offs.
cutoffs = seq(0.001, 0.999, by = 0.001)

cutoff_census <- data.frame(cutoff = numeric(),
                            TP_sum = integer(),
                            TN_sum = integer(),
                            FP_sum = integer(),
                            FN_sum = integer(),
                            stringsAsFactors = FALSE)

#We create a for loop to create a dataframe having TP, TN, FP, FN values for each cutoff value from 0.001 to 0.0.999.
for (cutoff in cutoff_values) {
  temporaray <- data.frame(
    real = census_Dtree_pred$Real_Y,
    predicted = as.numeric(census_Dtree_pred$Predicted_Y > cutoff)
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
  cutoff_census <- bind_rows(cutoff_census, data.frame(cutoff = cutoff, sums))}

#Let's give the columns much cleaner names.
cutoff_census = cutoff_census %>% rename("TP" = "TP_sum",
                                        "TN" = "TN_sum",
                                        "FP" = "FP_sum",
                                        "FN" = "FN_sum")

#Let's calculate Accuracy, Sn, Sp, Distance, KS, M for each cutoff and add them to cutoff_data.
cutoff_census = cutoff_census %>% mutate(P = TP + FN,
                                     N = TN + FP,
                                     Accuracy = (TP+TN)/(P+N),
                                     Sn = TP/P,
                                     Sp = TN/N,
                                     Distance = sqrt((1-Sn)^2+(1-Sp)^2),
                                     KS = (TP/P) - (FP/N),
                                     M = ((9*FN)+(0.6*FP))/(1.9*(P+N)))

View(cutoff_census)

#Let's find the cutoff value for which,
#(i) Distance in minimum, and the minimum Distance
cutoff_census$cutoff[which.min(cutoff_census$Distance)] [1]
min(cutoff_census$Distance)

#(ii) Accuracy is maximum, and the maximum Accuracy
cutoff_census$cutoff[which.max(cutoff_census$Accuracy)] [1]
max(cutoff_census$Accuracy) #0.8409335

#(iii) KS is maximum, and the maximum KS
cutoff_census$cutoff[which.max(cutoff_census$KS)] [1]
max(cutoff_census$KS)

#(iv) M is minimum, and the minimum M
cutoff_census$cutoff[which.min(cutoff_census$M)] [1]
min(cutoff_census$M)