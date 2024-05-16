This was a project given by our instructor at Edavncer during the course period while we were studying Binary Logistic Regression.

# Project Title: Predicting Income Level

## Project Overview
This project aims to predict the income level of individuals into two categories: more than $50k and less than $50k. The classification models built in this project uses various demographic and financial features to make predictions.

## Dataset Description
The dataset contains several attributes related to the individuals' demographic and financial details. Here is a brief overview of the columns in the dataset:

- `REF_NO`: _numeric_: Reference number for the individual
- `children`: _character_: Number of children
- `age_band`: _character_: Age band of the individual
- `status`: Marital status
- `occupation`: Occupation of the individual
- `occupation_partner`: Occupation of the partner
- `home_status`: Home ownership status
- `family_income`: Total family income
- `self_employed`: Whether the individual is self-employed
- `self_employed_partner`: Whether the partner is self-employed
- `year_last_moved`: The last year in which the individual moved
- `TVarea`: Television area
- `post_code`: Postal code
- `post_area`: Postal area
- `Average.Credit.Card.Transaction`: Average credit card transaction
- `Balance.Transfer`: Balance transfer
- `Term.Deposit`: Term deposit
- `Life.Insurance`: Life insurance
- `Medical.Insurance`: Medical insurance
- `Average.A.C.Balance`: Average account balance
- `Personal.Loan`: Personal loan
- `Investment.in.Mutual.Fund`: Investment in mutual funds
- `Investment.Tax.Saving.Bond`: Investment in tax saving bonds
- `Home.Loan`: Home loan
- `Online.Purchase.Amount`: Online purchase amount
- `Revenue.Grid`: Target variable indicating income level (>=50k, <50k)
- `gender`: Gender of the individual
- `region`: Region where the individual lives
- `Investment.in.Commudity`: Investment in commodities
- `Investment.in.Equity`: Investment in equity
- `Investment.in.Derivative`: Investment in derivatives
- `Portfolio.Balance`: Balance of the portfolio

## Objectives
- To develop a predictive model that accurately classifies individuals into two income levels based on their demographic and financial information.
- To identify key factors that significantly influence an individual's income level.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: dplyr, ggplot2, cvTools, randomForest, car, caret, pROC

## Model Development
- Data Preparation: The columns age_band, status, occupation, occupation_partner, home_status, family_income, TVArea and a few others were of chr type,so converted them into dummies. Further, converted the target variable to 0 and 1. Then split the whole data into train and test. 
- Logistic Regression: First, I used binary logistic regression to build the predictive model. Removed variables based on high Variation Inflation Factor (vif) values. Finalized my model and predicted for the test data.
- Random Forest: Then, used random forest algorithm with hyper parameter tuning to arrive at the best parameter values. Then built the model and performed prediction on test data.

## Conclusions
The logistic regression algorithm predicted the target variable with an accuracy of 93% which was further enhanced by random forest with an accuracy of 96%.

## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the dataset used, R script files with comment on each code line so it should be easy to follow along.
