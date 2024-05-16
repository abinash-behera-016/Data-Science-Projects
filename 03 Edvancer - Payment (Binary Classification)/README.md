This was a project given by our instructor at Edavncer as an ssignment during the course period while we were studying Linear Regression.

# Project Title: Predicting Income Level

## Project Overview
This project aims to predict the outcome of a payment, whether it was successful or not. 

## Dataset Description
The dataset contains several techincal attributes related to the payment process. The column names were ambiguous and didn't have any information associated.

## Objectives
- To develop predictive models that accurately classify payment instances into two levels 'Success' and 'Denied'.
- To identify key factors that significantly influence a payment's success.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: dplyr, ggplot2, cvTools, randomForest, car, caret, pROC

## Model Development
- __Data Preparation__: The columns 'var1','var2', 'var9','var10', 'var11', 'var13', 'var17', 'var19', 'var23', 'var29' were of chr type,so converted them into dummies. Further, converted the target variable to 0 and 1. Then split the whole data into train and test. 
- __Logistic Regression__: First, I used Linear Regression to remove variables based on high Variation Inflation Factor (vif) values. Then used binary logistic regression to build the predictive model.Finalized my model and predicted for the test data.
- __Random Forest__: Then, used random forest algorithm with hyper parameter tuning to arrive at the best parameter values. Then built the model and performed prediction on test data.

## Conclusions
The logistic regression algorithm predicted the target variable with an accuracy of 86% which was slightly enhanced by random forest with an accuracy of 87%.

## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the R script files with comment on each code line so it should be easy to follow along.
