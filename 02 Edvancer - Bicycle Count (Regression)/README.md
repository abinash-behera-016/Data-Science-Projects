This project was one of the assignments given by our instructor at Edvancer after completion of the linear regression module.

# Project Title: Predicting Bicycle Rental Counts

## Project Overview
The focus of the project is to predict the number of bicycles rented on a particular day. The regression models used in this project take various weather, time and calender information to predict the number of bicycle rentals.

## Dataset Description
This dataset consists of weather, time and calender details. Here is a brief overview of the coloumns present in the dataset.
- `instant`: _numeric_: ID column
- `dteday`: _character_: Date on which the observation was taken
- `season`: _numeric_: Season in which the observation was taken, has numeric values from 1 to 6
- `yr`: _numeric_: Count of years passed from the day the first observation was taken, ranges from 0 to 1
- `mnth`: _numeric_: Season in which the observation was taken, has numeric values from 1 to 12
- `weekday`: _numeric_: Day of the week, ranges from 1 to 6
- `workingday`: _numeric_: Whether it was a working day or not
- `weathersit`: _numeric_: Weather situation, ranges from 1 to 3 for sunny, rainy and cloudy
- `temp`: _numeric_: Apparent or feels like temperature
- `atemp`: _numeric_: Actual temperature
- `hum`: _numeric_: Humidity
- `windspeed`: _numeric_: Wind speed
- `casual`: _numeric_: Count of casual users
- `registered`: _numeric_: Count of registered users
- `cnt`: _numeric_: Total users

## Objectives
- To develop predictive models that accurately predict the number of bicycle rentals on a given day based on various weather, time and calender information.
- To identify key factors that significantly influence the number of bicycle rentals.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: dplyr, ggplot2, cvTools, tree, car, caret, pROC

## Model Development
- __Data Preparation__: Almost all columns were already of the numeric type. Still, chose to treat 'season','mnth', 'weekday','weathersit' as chr columns and created dummies for them.
- __Linear Regression__: First, I used Linear Regression to remove variables based on high Variation Inflation Factor (vif) values. Then I further removed irrelavant variables based on AIC values. After that, I finalized my model predicted for the test data.
- __Decision Tree__: Built a decision tree model with parameter values maxdepth = 5, minsplit = 10, minbucket = 5, splitrule = "gini" and predicted on test data.

## Conclusions
The linear regression algorithm predicted the target variable with an rmse of 10.25. However, decision tree algorithm wasn't very successful with an rmse of over 50.

## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the R script files with comment on each code line so it should be easy to follow along.
