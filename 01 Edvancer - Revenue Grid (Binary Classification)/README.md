This was a project given by our instructor at Edavncer during the course period while we were studying Binary Logistic Regression.


# Project Title: Predicting Income Level

## Project Overview
This project aims to predict the income level of individuals into two categories: more than $50k and less than $50k. The classification models built in this project uses various demographic and financial features to make predictions.

## Dataset Description
The dataset contains several attributes related to the individuals' demographic and financial details. Here is a brief overview of the columns in the dataset:

- `REF_NO`: _numeric_: Reference number for the individual
- `children`: _character_: Number of children
- `age_band`: _character_: Age band of the individual
- `status`: _character_: Marital status
- `occupation`: _character_: Occupation of the individual
- `occupation_partner`: _character_: Occupation of the partner
- `home_status`: _character_: Home ownership status
- `family_income`: _character_: Total family income
- `self_employed`: _character_: Whether the individual is self-employed
- `self_employed_partner`: _character_: Whether the partner is self-employed
- `year_last_moved`: _numeric_: The last year in which the individual moved
- `TVarea`: _character_: Television area
- `post_code`: _character_: Postal code
- `post_area`: _character_: Postal area
- `Average.Credit.Card.Transaction`: _numeric_: Average credit card transaction
- `Balance.Transfer`: _numeric_: Balance transfer
- `Term.Deposit`: _numeric_: Term deposit
- `Life.Insurance`: _numeric_: Life insurance
- `Medical.Insurance`: _numeric_: Medical insurance
- `Average.A.C.Balance`: _numeric_: Average account balance
- `Personal.Loan`: _numeric_: Personal loan
- `Investment.in.Mutual.Fund`: _numeric_: Investment in mutual funds
- `Investment.Tax.Saving.Bond`: _numeric_: Investment in tax saving bonds
- `Home.Loan`: _numeric_: Home loan
- `Online.Purchase.Amount`: _numeric_: Online purchase amount
- `Revenue.Grid`: _numeric_: Target variable indicating income level (>=50k, <50k)
- `gender`: _character_: Gender of the individual
- `region`: _character_: Region where the individual lives
- `Investment.in.Commudity`: _numeric_: Investment in commodities
- `Investment.in.Equity`: _numeric_: Investment in equity
- `Investment.in.Derivative`: _numeric_: Investment in derivatives
- `Portfolio.Balance`: _numeric_: Balance of the portfolio

## Objectives
- To develop predictive models that accurately classify individuals into two income levels based on their demographic and financial information.
- To identify key factors that significantly influence an individual's income level.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: dplyr, ggplot2, cvTools, randomForest, car, caret, pROC

## Model Development
- __Data Preparation__: The columns age_band, status, occupation, occupation_partner, home_status, family_income, TVArea and a few others were of chr type,so converted them into dummies. Further, converted the target variable to 0 and 1. Then split the whole data into train and test. 
- __Logistic Regression__: First, I used Linear Regression to remove variables based on high Variation Inflation Factor (vif) values. Then used binary logistic regression to build the predictive model.Finalized my model and predicted for the test data.
- __Random Forest__: Then, used random forest algorithm with hyper parameter tuning to arrive at the best parameter values. Then built the model and performed prediction on test data.

## Conclusions
The logistic regression algorithm predicted the target variable with an accuracy of 93% which was further enhanced by random forest with an accuracy of 96%.

## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the R script files with comment on each code line so it should be easy to follow along.
