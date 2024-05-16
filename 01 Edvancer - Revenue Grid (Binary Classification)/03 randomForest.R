#Let's load the necessary packages first.
library(randomForest)
library(cvTools)
library(pROC)
library(caret)

#In case of a classification problem, RF algorithm requires the target vriable to be of factor type.
rg_train$Revenue.Grid <- factor(rg_train$Revenue.Grid)
default_data_test$loan_default <- factor(default_data_test$loan_default)

#Let's create a list containing possible values of RF hyper parameters which the model can use later.
#mtry: No of random predictors selected at each split. Keep between p/3 to sqrt(p).
#Lower: More randomness, diverse. Higher: Less randomness, high correlation.

#ntree: Total number of trees in the forest. Keep around 5% to 15% of total number of observations.
#Larger: Always better but very computationally intensive.

#maxnodes: Maximum no of terminal nodes(leaf). Keep around sqrt(number of observations).
#Lower: Good for small datasets. Higher: Goof large datasets, captures complex patterns. Overfiting risk.

#nodesize: Minimum number of nodes(obs) required to create a terminal node(leaf) in a tree. 1% to 5% of total obs.
#Lower: large trees capturing finer details,overfitting risk. Higher: small trees, no overfitting, miss finer details.

parameters = list(
  mtry = c(8, 15, 25, 30),
  ntree = c(500, 700, 1500),
  maxnodes = c(30, 50, 65, 80),
  nodesize = c(50, 75, 100, 200)
)


#This list has 6*5*7*4 = 840 combinations, and if we do a 10-fold cross-validation and
#each RF had 100 trees, 840*10*100 = 8,40,000 tress will be built. It's way too resource intensive.
#So out of all combinations, we'll select a random set of 50 combinations using the custom function below.
subset_parameters = function(full_list_para, n = 10)
{all_comb = expand.grid(full_list_para)
s = sample(1:nrow(all_comb), n)
subset_para = all_comb[s,]
return(subset_para)}

#A function to calculate AUC score.
mycost_auc = function(y, yhat){
  roccurve = pROC::roc(y,yhat)
  score = pROC::auc(roccurve)
  return(score)
}

num_trials = 50
my_parameters = subset_parameters(parameters, num_trials)
View(my_parameters)

#We'll use cvTuning function to try out all those 80 possible combinations.
#Being a classifiction problem, we'll look at auc score for every combination and choose the one with the most auc.
#We'll put random starting auc value. Whenever a combination with more auc comes, that'll be selected and so on.
#The last combination with the highest auc will be our final choice of combination.
#K is the no of folds in cross-validation. 10 means whole data will be split into 10 parts.
#Model will be trained with 9 parts and validated with 1 part.
#All the print functions in the for loop is to print the current progress.
myauc = 0

for (i in 1:num_trials) {
  print(paste0('starting iteration:', i))
  parameters = my_parameters[i,]
  
  k = cvTuning(randomForest, Revenue.Grid ~ .,
               data = rg_train, 
               tuning = parameters,
               folds = cvFolds(nrow(rg_train), K = 10, type = "random"),
               cost = mycost_auc,
               seed = 2,
               predictArgs = list(type = "prob"))
  
  score.this = k$cv[, 2]
  
  if (score.this > myauc) {
    print(parameters)
    myauc = score.this
    print(myauc)
    best_parameters = parameters
  }
  print('Done')
}

#To know least error and best combination,
myauc
best_parameters

#Now we have the best combination of parameters, we'll now use  those values to create our final model.
rg_rF = randomForest(Revenue.Grid ~.,
                           mtry = 30,
                           ntree = 500,
                           maxnodes = 50,
                           nodesize = 50,
                           data = rg_train)

#Let's predict on the test data.
rg_preds_rF = predict(rg_rF, newdata = rg_test)

#Let's check the performance of the model on train data.
auc_rg_rF = auc(roc(rg_test$Revenue.Grid, as.numeric(rg_preds_rF)))
auc_rg_rF #0.8595

#Let's save the test score in a dataframe and visualize.
rg_pred_rF = data.frame(Revenue.Grid = rg_test$Revenue.Grid, train_score = rg_preds_rF)
ggplot(rg_pred_rF, aes(y = Revenue.Grid, x = train_score, color = factor(Revenue.Grid))) + geom_point() + geom_jitter()

View(cutoff_rg_rF)
rg_pred_rF$Revenue.Grid <- factor(rg_pred_rF$Revenue.Grid)
rg_pred_rF$train_score <- factor(rg_pred_rF$train_score)

confusionMatrix(rg_pred_rF$Revenue.Grid, rg_pred_rF$train_score) #Accuracy = 0.9591