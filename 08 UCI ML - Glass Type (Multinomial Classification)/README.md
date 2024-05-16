Obtained this dataset from UCI Machine Learning repository, This was originally from from the USA Forensic Science Service; 6 types of glass; defined in terms of their oxide content (i.e. Na, Fe, K, etc). The study of classification of types of glass was motivated by criminological investigation.  At the scene of the crime, the glass left can be used as evidence...if it is correctly identified!

# Predicting Glass Type
## Project Overview
This project aims to predict the type of different glass into six categories: encoded as 1, 2, 3, 5, 6, 7. The classification models built in this project uses various oxide content information to make predictions.

## Dataset Description
The dataset contains several attributes related to the type of different glass. Here is a brief overview of the columns in the dataset:

- `RI`: *numerical*: Refractive index of the glass.
- `Na`: *numerical*: Sodium (Na) content in the glass.
- `Mg`: *numerical*: Magnesium (Mg) content in the glass.
- `Al`: *numerical*: Aluminum (Al) content in the glass.
- `Si`: *numerical*: Silicon (Si) content in the glass.
- `K`: *numerical*: Potassium (K) content in the glass.
- `Ca`: *numerical*: Calcium (Ca) content in the glass.
- `Ba`: *numerical*: Barium (Ba) content in the glass.
- `Fe`: *numerical*: Iron (Fe) content in the glass.
- `Type`: *character*: Type of glass. It is the target variable, representing different glass types/classes.

## Objectives
- To develop predictive models that accurately classify different glass types into six categories based on their refractive index and oxide content information.
- To identify key factors that significantly influence type of glass.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: dplyr, ggplot2, cvTools, nnet, car, caret, pROC

## Model Development
- __Data Preparation__: All the columns were of numeric type. So no overall data processing was required. Split the whole data into train and test.
- __Linear Regression__: Converted the target into numeric type and performed a linear regression task. Finalized the model and predicted on the test data.
- __Multinomial Logistic Regression__: Used multinomial logistic classification to build the predictive model using the nnet package and predicted for the test data.

## Conclusions
The linear regression algorithm predicted the target variable with an rmse of 1.04 and the multinomial logistic regression showed an accuracy of 100%.

## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the R script files with comment on each code line so it should be easy to follow along.
