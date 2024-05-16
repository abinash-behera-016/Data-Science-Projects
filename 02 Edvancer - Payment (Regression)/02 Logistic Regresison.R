#Load the necessary packages
library(dplyr)
library(ggplot2)
library(car)
library(caret)
library(fastDummies)
library(pROC)

#let's first build a linear regression model to filter out predictors based on vif values.
pday_fit = lm(payment_bin~. -var17_bw, data = pday_train)
sort(vif(pday_fit), decreasing = T) [1:5]

#Let's now build the generalized logistic regression model and filter out predictors based on AIC values.
pday_glm = glm(payment_bin~. -var17_bw, data = pday_train)
pday_glm = stats::step(pday_glm)

#Let's predict the target variable on the test data now.
pday_glm_pred = predict(pday_glm, newdata = pday_train)

#Let's create a new dataset having the actual and predicted values.
pday_glm_pred = data.frame(payment = pday_test$payment_bin, predicted = predict(pday_glm, newdata = pday_test))

#Let's calculate the auc score.
auc(roc(pday_glm_pred$payment, pday_glm_pred$predicted)) #0.8822

#Let's calculate different evaluation metrics for a range of cut offs.
cutoff_values = seq(0.001, 0.999, by = 0.001)

#We create a for loop to create a dataframe having TP, TN, FP, FN values for each cutoff value from 0.001 to 0.0.999.
cutoff_pday <- data.frame(cutoff = numeric(),
                                  TP_sum = integer(),
                                  TN_sum = integer(),
                                  FP_sum = integer(),
                                  FN_sum = integer(),
                                  stringsAsFactors = FALSE
)



for (cutoff in cutoff_values) {
  temporaray <- data.frame(
    real = pday_glm_pred$payment,
    predicted = as.numeric(pday_glm_pred$predicted > cutoff)
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
  cutoff_pday <- bind_rows(cutoff_pday, data.frame(cutoff = cutoff, sums))
}

#Let's give the columns a much cleaner names.
cutoff_pday = cutoff_pday %>% rename("TP" = "TP_sum",
                                                     "TN" = "TN_sum",
                                                     "FP" = "FP_sum",
                                                     "FN" = "FN_sum")
#Let's calculate Accuracy, Sn, Sp, Distance, KS, M for each cutoff and add them to cutoff_data.
cutoff_pday = cutoff_pday %>% mutate(P = TP + FN,
                                                     N = TN + FP,
                                                     Accuracy = (TP+TN)/(P+N),
                                                     Sn = TP/P,
                                                     Sp = TN/N,
                                                     Distance = sqrt((1-Sn)^2+(1-Sp)^2),
                                                     KS = (TP/P) - (FP/N),
                                                     M = ((9*FN)+(0.6*FP))/(1.9*(P+N)))


#Let's find the cutoff value for which,
#(i) Distance in minimum, and the minimum Distance
cutoff_pday$cutoff[which.min(cutoff_pday$Distance)] [1]
min(cutoff_pday$Distance)

#(ii) Accuracy is maximum, and the maximum Accuracy
cutoff_pday$cutoff[which.max(cutoff_pday$Accuracy)] [1]
max(cutoff_pday$Accuracy) #0.8643333

#(iii) KS is maximum, and the maximum KS
cutoff_pday$cutoff[which.max(cutoff_pday$KS)] [1]
max(cutoff_pday$KS)

#(iv) M is minimum, and the minimum M
cutoff_pday$cutoff[which.min(cutoff_pday$M)] [1]
min(cutoff_pday$M)