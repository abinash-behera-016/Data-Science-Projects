This dataset was provided by our instructor during our course period. It was one of the assignments for us during the regression module.

# Predicting Interest Rate
## Project Overview

This project aims to predict the interest rate (`Interest.Rate`) for loans based on various factors related to the loan applicant and the loan details. The prediction model can help in assessing loan affordability and risk associated with different loan applications.

## Dataset Description

The dataset comprises several attributes that are believed to influence the interest rate assigned to a loan. Here is a brief overview of the key columns included in the dataset:

- `ID`: _numeric_: Unique identifier for each loan
- `Amount.Requested`: _numeric_: The amount of loan requested by the borrower
- `Amount.Funded.By.Investors`: _numeric_: The amount of loan funded by investors
- `Interest.Rate`: _character_: The interest rate of the loan (target variable)
- `Loan.Length`: _character_: The term of the loan
- `Loan.Purpose`: _character_: The purpose of the loan (e.g., debt consolidation, home improvement)
- `Debt.To.Income.Ratio`: _character_: Borrower's debt-to-income ratio
- `State`: _character_: The state in which the borrower resides
- `Home.Ownership`: _character_: The home ownership status of the borrower (e.g., rent, own)
- `Monthly.Income`: _numeric_: The monthly income of the borrower
- `FICO.Range`: _character_: The FICO credit score range of the borrower
- `Open.CREDIT.Lines`: _numeric_: The number of open credit lines in the borrower's credit report
- `Revolving.CREDIT.Balance`: _numeric_: Total revolving credit balance
- `Inquiries.in.the.Last.6.Months`: _numeric_: Number of credit inquiries in the past six months
- `Employment.Length`: _character_: Length of employment

## Objectives
- To develop predictive models that accurately predicts the recommended Interest Rate for individuals demographic and financial information.
- To identify key factors that significantly influence an individual's suggested Interest Rate.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: dplyr, ggplot2, cvTools, XGBoost, car, caret, pROC

## Model Development
- __Data Preparation__: The columns 'Home.Ownership','Employment.Length', 'State','Loan.Purpose', 'Loan.Length' were of chr type,so converted them into dummies. Further, converted Interest.Rate and Debt.To.Income.Ratio to numeric by removing the % symbol. Then split the whole data into train and test. 
- __Linear Regression__: First, used Linear Regression to remove variables based on high Variation Inflation Factor (vif) values. Finalized my model and predicted for the test data.
- __Random Forest__: Then, used XGBpoost algorithm with manual hyper parameter tuning to arrive at the best parameter values. Then built the model and performed prediction on test data.

## Conclusions
The linear regression algorithm predicted the target variable with an rmse of 2.08 which was further enhanced by XGBoost to 1.76.

## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the R script files with comment on each code line so it should be easy to follow along.
