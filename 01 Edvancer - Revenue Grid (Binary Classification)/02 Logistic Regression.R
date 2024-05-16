#Load the necessary packages
library(dplyr)
library(ggplot2)
library(car)
library(pROC)


##First we run linear regression to eliminate predictors with severe VIF.
rg_vif = lm(Revenue.Grid ~.-REF_NO, data = rg_train)
sort(vif(rg_vif), decreasing = T) [1:5]

#There are aliased coefficients present in the model. Let's find and remove those.
cor(rg_train)
alias(rg_vif) #Better

#Let's make the model again and remove variables based on vif values.
rg_vif = lm(Revenue.Grid ~.-REF_NO 
            -inv_comm -inv_derv -inv_equi
            -oc_pt_oth -oc_pro -Portfolio.Balance, data = rg_train)
sort(vif(rg_vif), decreasing = T) [1:5]

#All VIF values are under 10 now. Let's proceed to making the logistic model by copying the above formula.
rg_glm = glm(Revenue.Grid ~.-REF_NO 
             -inv_comm -inv_derv -inv_equi
             -oc_pt_oth -oc_pro -Portfolio.Balance, data = rg_train)

#Now let's drop variables based on AIC values.
rg_glm = stats::step(rg_glm)

#Dropping variables based on p-values below.
rg_glm = glm(Revenue.Grid ~ Balance.Transfer + Term.Deposit + 
               Life.Insurance + Medical.Insurance + Average.A.C.Balance + 
               Personal.Loan + Home.Loan + 
               avg_credit_txn + inv_bond + on_purscs, data = rg_train)

summary(rg_glm)

#Let's check the performance of our model on train data.
glm_predict_rg = predict(rg_glm, newdata = rg_test, type = 'response')
auc_rg_glm = auc(roc(rg_test$Revenue.Grid, glm_predict_rg))
auc_rg_glm #0.9369

#Let's save the test score in a dataframe and visualize.
rg_glm_predictions = data.frame(Revenue.Grid = rg_test$Revenue.Grid, predicted_score = glm_predict_rg)
ggplot(rg_glm_predictions, aes(y=Revenue.Grid, x=predicted_score, color=factor(Revenue.Grid))) + geom_point() + geom_jitter() + xlim(0,1)


#Let's create a set of possible cut-offs between 0.001 to 0.999, with an increment of 0.001 in every step.
#This should generate 1000 possible values of cutoffs.
cutoff_values = seq(0.001, 0.999, by = 0.001)

#We create a for loop to create a dataframe having TP, TN, FP, FN values for each cutoff value from 0.001 to 0.0.999.
cutoff_rg_glm <- data.frame(cutoff = numeric(),
                          TP_sum = integer(),
                          TN_sum = integer(),
                          FP_sum = integer(),
                          FN_sum = integer(),
                          stringsAsFactors = FALSE
)



for (cutoff in cutoff_values) {
  temporaray <- data.frame(
    real = rg_glm_predictions$Revenue.Grid,
    predicted = as.numeric(glm_predict_rg > cutoff)
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
  cutoff_rg_glm <- bind_rows(cutoff_rg_glm, data.frame(cutoff = cutoff, sums))
}

#Let's give the columns a much cleaner names.
cutoff_rg_glm = cutoff_rg_glm %>% rename("TP" = "TP_sum",
                                                     "TN" = "TN_sum",
                                                     "FP" = "FP_sum",
                                                     "FN" = "FN_sum")
#Let's calculate Accuracy, Sn, Sp, Distance, KS, M for each cutoff and add them to cutoff_data.
cutoff_rg_glm = cutoff_rg_glm %>% mutate(P = TP + FN,
                                     N = TN + FP,
                                     Accuracy = (TP+TN)/(P+N),
                                     Sn = TP/P,
                                     Sp = TN/N,
                                     Distance = sqrt((1-Sn)^2+(1-Sp)^2),
                                     KS = (TP/P) - (FP/N),
                                     M = ((9*FN)+(0.6*FP))/(1.9*(P+N)))

#Let's find the cutoff value for which,
#(i) Distance in minimum, and the minimum Distance
cutoff_rg_glm$cutoff[which.min(cutoff_rg_glm$Distance)] [1]
min(cutoff_rg_glm$Distance)

#(ii) Accuracy is maximum, and the maximum Accuracy
cutoff_rg_glm$cutoff[which.max(cutoff_rg_glm$Accuracy)] [1]
max(cutoff_rg_glm$Accuracy) #0.9281289

#(iii) KS is maximum, and the maximum KS
cutoff_rg_glm$cutoff[which.max(cutoff_rg_glm$KS)] [1]
max(cutoff_rg_glm$KS)

#(iv) M is minimum, and the minimum M
cutoff_rg_glm$cutoff[which.min(cutoff_rg_glm$M)] [1]
min(cutoff_rg_glm$M)