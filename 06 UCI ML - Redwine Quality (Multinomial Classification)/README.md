Obtained from the UCI Machine Learning repository, this dataset contains red vinho verde wine samples,from the north of Portugal. The goal is to model wine quality based on physicochemical tests. This dataset can be viewed as classification or regression tasks.

# Predicting Red Wine Quality

## Project Overview
This project aims to predict the quality  (mouth feel) of red wines into 10 categories: 0 to 10. The dataset has had values typically ranging from 3 to 7 however. The regression and classification models built in this project uses physicochemical features to make predictions.

## Dataset Description
The dataset contains several attributes related to the individual wines physicochemical details. Here is a brief overview of the columns in the dataset:

- `fixed_acidity`: *numeric*: Level of acidity in the wine
- `volatile_acidity`: *numeric*: Volatile acidity level in the wine
- `citric_acid`: *numeric*: Citric acid content in the wine
- `residual_sugar`: *numeric*: Residual sugar content in the wine
- `chlorides`: *numeric*: Chloride content in the wine
- `free_sulfur_dioxide`: *numeric*: Amount of free sulfur dioxide in the wine
- `total_sulfur_dioxide`: *numeric*: Total sulfur dioxide content in the wine
- `density`: *numeric*: Density of the wine
- `pH`: *numeric*: pH level of the wine
- `sulphates`: *numeric*: Sulphate content in the wine
- `alcohol`: *numeric*: Alcohol content in the wine
- `quality`: *numeric*: Quality rating of the wine (target variable)

## Objectives
- To develop predictive models that accurately classify wines into ten quality levels based on their physicochemical information.
- To identify key factors that significantly influence a wine's quality level.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: dplyr, ggplot2, cvTools, randomForest, xgboost, car, caret, pROC.

## Model Development
- __Data Preparation__: All the columns were of numeric type so no dummy creation was necessary. Split the whole data into train and test in the ratio 80%-20%.
- __Logistic Regression__: First, I used Linear Regression to remove variables based on high Variation Inflation Factor (vif) values. Built the predictive model.Finalized my model and predicted for the test data.
- __XGBoost__: Agin treated the problem as a regression one and built an xgb model to predict for the test data.
- __Random Forest__: Finally, treated the problem as multinomial classification problem and used random forest algorithm with hyper parameter tuning to arrive at the best parameter values. Then built the model and performed prediction for various classes on test data.

## Conclusions
The linear regression algorithm predicted the target variable with an rmse of 0.67 which was further enhanced by XGBoost with an rmse of 0.50. Random forest multinomial classification model captured classes with an accuracy of 73%.

## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the R script files with comment on each code line so it should be easy to follow along.
