From UCI Machine Learning repository, this dataset was created in a project that aims to contribute to the reduction of academic dropout and failure in higher education, by using machine learning techniques to identify students at risk at an early stage of their academic path, so that strategies to support them can be put into place. 

The dataset includes information known at the time of student enrollment – academic path, demographics, and social-economic factors. 

The problem is formulated as a three category classification task (dropout, enrolled, and graduate) at the end of the normal duration of the course.

# Predicting Graduation Status

## Project Overview
This project aims to predict the igraduation status of students of various educational and financial background into three categories: Dropout, Enrolled, Graduate. The classification models built in this project uses various educational, demographic and financial features to make predictions.

## Dataset Description
The dataset contains several attributes related to the student's educational, demographic and financial details. Here is a brief overview of the columns in the dataset:


- `Marital_status`: _numeric_: Marital status of the student.
- `Application_mode`: _numeric_: Mode of application for enrollment.
- `Application_order`: _numeric_: Order of application.
- `Course`: _numeric_: Course or program enrolled in.
- `Daytime/evening_attendance`: _numeric_: Attendance schedule (daytime or evening).
- `Previous_qualification`: _numeric_: Previous educational qualification of the student.
- `Previous_qualification_grade`: _numeric_: Grade or performance in the previous qualification.
- `Nationality`: _numeric_: Nationality of the student.
- `Mothers_qualification`: _numeric_: Educational qualification of the student's mother.
- `Fathers_qualification`: _numeric_: Educational qualification of the student's father.
- `Mothers_occupation`: _numeric_: Occupation of the student's mother.
- `Fathers_occupation`: _numeric_: Occupation of the student's father.
- `Admission_grade`: _numeric_: Grade achieved during admission.
- `Displaced`: _numeric_: Indicator if the student was displaced.
- `Educational_special_needs`: _numeric_: Indicator for educational special needs.
- `Debtor`: _numeric_: Indicator for being a debtor.
- `fees_uptodate`: _numeric_: Indicator for fees payment status.
- `Gender`: _numeric_: Gender of the student.
- `Scholarship_holder`: _numeric_: Indicator if the student holds a scholarship.
- `Age_at_enrollment`: _numeric_: Age of the student at enrollment.
- `International`: _numeric_: Indicator for international status.
- `CLrunits_1stsem_credited`: _numeric_: Credit units credited in the first semester.
- `CLrunits_1stsem_enrolled`: _numeric_: Credit units enrolled in the first semester.
- `CLrunits_1stsem_evaluations`: _numeric_: Number of evaluations in the first semester.
- `CLrunits_1stsem_approved`: _numeric_: Credit units approved in the first semester.
- `CLrunits_1stsem_grade`: _numeric_: Grade achieved in the first semester.
- `CLrunits_1stsem_no_evaluations`: _numeric_: Number of evaluations not conducted in the first semester.
- `CLrunits_2nd_sem_credited`: _numeric_: Credit units credited in the second semester.
- `CLrunits_2nd_sem_enrolled`: _numeric_: Credit units enrolled in the second semester.
- `CLrunits_2ndsem_evaluations`: _numeric_: Number of evaluations in the second semester.
- `CLrunits_2nd_sem_approved`: _numeric_: Credit units approved in the second semester.
- `CLrunits_2ndsem_grade`: _numeric_: Grade achieved in the second semester.
- `CLrunits_2ndsem_no_evaluations`: _numeric_: Number of evaluations not conducted in the second semester.
- `Unemployment_rate`: _numeric_: Unemployment rate at the time of enrollment.
- `Inflation_rate`: _numeric_: Inflation rate at the time of enrollment.
- `GDP`: _numeric_: Gross Domestic Product at the time of enrollment.
- `Target`: _character_: Target variable indicating student's graduation status (Dropout, Enrolled, Graduate).

## Objectives
- To develop predictive models that accurately classify students into three graduation status based on their educational, demographic and financial information.
- To identify key factors that significantly influence a student's graduation status.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: dplyr, ggplot2, cvTools, nnet, xgboost, car, caret, pROC

## Model Development
- __Data Preparation__: All the coulmns were of numeric type. SO didn't need any overall data processing steps. Split the whole data into train and test. 
- __Multinomial Logistic Regression__: Used multinomial logistic regression using nnect package to build the predictive model.Finalized my model and predicted for the test data.
- __XGBoost__: Converted the target variable to factors wilth levels 0, 1,2. Then, used XGBoost algorithm with manual hyper parameter tuning to arrive at the best parameter values. Then built the model and performed prediction on test data.

## Conclusions
The logistic regression algorithm predicted the target variable with an accuracy of 77% which was further enhanced by XGBoost with an accuracy of 84%.

## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the R script files with comment on each code line so it should be easy to follow along.
