#Let's load the necessary packages.
library(randomForest)
library(pROC)
library(cvTools)

pday_train$payment_bin <- factor(pday_train$payment_bin)

parameters_pday = list(
  mtry = c(10, 20, 25, 35, 45),
  ntree = c(50, 100, 200, 500, 700),
  maxnodes = c(5, 10, 15, 20, 30, 50, 100),
  nodesize = c(1, 2, 5, 10)
)

#This list has 6*5*7*4 = 840 combinations, and if we do a 10-fold cross-validation and
#each RF had 100 trees, 840*10*100 = 8,40,000 tress will be built. It's way too resource intensive.
#So out of all combinations, we'll select a random set of 20 combinations.

#A function to calculate AUC score.
mycost_auc = function(y, yhat){
  roccurve = pROC::roc(y,yhat)
  score = pROC::auc(roccurve)
  return(score)
}

subset_parameters = function(full_list_para, n = 10)
{all_comb = expand.grid(full_list_para)
s = sample(1:nrow(all_comb), n)
subset_para = all_comb[s,]
return(subset_para)}

num_trials = 10
my_pday_parameters = subset_parameters(parameters_pday, num_trials)
View(my_pday_parameters)

#We'll use cvTuning function to try out all those 80 possible combinations.
#Being a classifiction problem, we'll look at auc score for every combination and choose the one with the most auc.
#We'll put random starting auc value. Whenever a combination with more auc comes, that'll be selected and so on.
#The last combination with the highest auc will be our final choice of combination.
#K is the no of folds in cross-validation. 10 means whole data will be split into 10 parts.
#Model will be trained with 9 parts and validated with 1 part.
#All the print functions in the for loop is to print the current progress.
myauc_pday = 0

for (i in 1:num_trials) {
  print(paste0('starting iteration:', i))
  parameters = my_pday_parameters[i,]
  
  k = cvTuning(randomForest, payment_bin ~ .,
               data = pday_train, 
               tuning = parameters,
               folds = cvFolds(nrow(pday_train), K = 6, type = "random"),
               cost = mycost_auc,
               seed = 2,
               predictArgs = list(type = "prob"))
  
  score.this = k$cv[, 2]
  
  if (score.this > myauc_pday) {
    print(parameters)
    myauc_pday = score.this
    print(myauc_pday)
    best_parameters = parameters
  }
  print('Done')
}

#To know least error and best combination,
myauc_pday
best_parameters

#Let's build the rF model now.
pday_rF = randomForest(payment_bin~.,
                           mtry = best_parameters$mtry,
                           ntree = best_parameters$ntree,
                           maxnodes = best_parameters$maxnodes,
                           nodesize = best_parameters$nodesize,
                           data = pday_train)

#Let's create a new dataset having the actual and predicted values.
pday_rF_pred = data.frame(payment = pday_test$payment_bin, predicted = predict(pday_rF, newdata = pday_test))

#Let's calculate the auc score.
auc(roc(as.numeric(pday_rF_pred$payment), as.numeric(pday_rF_pred$predicted))) #0.8586

#As the predictoions are in the format 1s and 0s, let's create a confusion matrix.
confusionMatrix(as.factor(pday_rF_pred$payment), as.factor(pday_rF_pred$predicted)) #Accuracy : 0.87