This was a project given by our instructor at Edavncer during the course period while we were studying Binary Logistic Regression.

# Income Level Prediction

## Project Overview

This project aims to predict income levels (`Y`) based on a range of demographic and employment-related characteristics. The income level is classified into two categories: <=50K and >50K annually. By analyzing these features, this model can assist in identifying the key predictors of income level and can be used for socio-economic studies, targeted marketing, policy making, and more.

## Dataset Description

The dataset used for this project includes several attributes related to the individuals' employment, education, and demographic background. Here is a brief overview of the columns in the dataset:

- `age`: _numeric_: Age of the individual.
- `workclass`: _character_: The work class (e.g., Private, Self-emp, Government).
- `fnlwgt`: _numeric_: Final weight, the number of people the census believes the entry represents.
- `education`: _character_: The highest level of education achieved by the individual.
- `education.num`: _numeric_: The highest level of education in numerical form.
- `marital.status`: _character_: Marital status of the individual.
- `occupation`: _character_: The individual’s occupation.
- `relationship`: _character_: Relationship with local contact.
- `race`: _character_: Race of the individual.
- `sex`: _character_: Gender of the individual.
- `capital.gain`: _numeric_: Income from investment sources other than wage/salary.
- `capital.loss`: _numeric_: Losses from investment sources other than wage/salary.
- `hours.per.week`: _numeric_: Number of hours worked per week.
- `native.country`: _character_: Country of origin for the individual.
- `Y`: _character_: Income level, with two classes: <=50K and >50K annually.

## Objectives
- To develop predictive models that accurately classify individuals into two income levels based on their demographic and financial information.
- To identify key factors that significantly influence an individual's income level.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: dplyr, ggplot2, cvTools, tree, rpart, rpart.plot, neuralnet, car, caret, pROC

## Model Development
- __Data Preparation__: The columns 'workclass','education', 'marital.status','relationship', 'race', 'native.country', 'occupation', 'sex' were of chr type,so converted them into dummies. Further, converted the target variable to 0 and 1. Then split the whole data into train and test. 
- __Decision Tree__: First, I used Decision Tree algorithm from the package 'rpart' with parameter values maxdepth = 5, minsplit = 10, minbucket = 5, splitrule = "gini" to build the predictive model. Finalized my model and predicted for the test data.
- __Neural Network__: Then, used neural network algorithm from 'neuralnet' package with manual hyper parameter tuning to builf the model and performed prediction on test data.

## Conclusions
The Decision Tree algorithm predicted the target variable with an accuracy of 84% with Neural Network lagging behind a bit with an accuracy of 80%.

## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the R script files with comment on each code line so it should be easy to follow along.
