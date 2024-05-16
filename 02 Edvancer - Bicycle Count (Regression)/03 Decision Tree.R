#Load the necessary packages
library(dplyr)
library(ggplot2)
library(tree)
library(rpart)
library(rpart.plot)

View(bicycle_train)

#Let's first define hyper parameter values.
dt_control <- rpart.control(maxdepth = 5, minsplit = 10, minbucket = 5, splitrule = "gini")

#Let's build a decision tree using the function rpart()
bicycle_tree = rpart(cnt~., data = bicycle_train, control = dt_control)
bicycle_tree

#Let's visualize the tree.
rpart.plot(bicycle_tree)

#Let's predict the outcome variable(Interest.Rate) on test data.
bicycle_Dtree = predict(bicycle_tree, newdata = bicycle_test)

#Performance of this tree model will be judged based on RMSE as we're predicting a continuous numerical variable.
rmse_bicycle_DTree = ((bicycle_Dtree) - (bicycle_test$cnt))^2 %>% mean() %>% sqrt()
rmse_bicycle_DTree