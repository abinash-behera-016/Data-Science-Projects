This dataset was obtained from Kaggle while I was working with Time Series Analysis during the course. It contains the number of monthly airline passengers starting from 1949 January to 1960 December.


# Predicting Airline Passengers

## Project Overview
This project aims to predict the number of airline passengers based on previously recorded monthly passenger figures.

## Dataset Description
The dataset contains contains two columns regarding the year-month and passenger count information. Here is a brief overview of the columns in the dataset:

- `Month`: _character_: Year and month of observation
- `International airline passengers: monthly totals in thousands. Jan 49 ? Dec 60`: _numeric_: Count of monthly passengers in thousands

## Objectives
- To develop a predictive model that accurately predicts the passenger count for the coming months based on previous year information.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: forecast, ggplot2, stats, dplyr, tseries

## Model Development
- __Data Preparation__: The columns 'International airline passengers: monthly totals in thousands. Jan 49 ? Dec 60' was renamed to 'no_of_passengers' for simplicity and the data was cconverted to time series object starting from the 1949, January as present in the 'Month' column. Thus the active use of 'Month' is not needed while building a time series model.
- __Auto Arima__: Initial plots suggested there was seasonality (gamma) present. Built a forecast model using the auto arima algorithm with and determined that it was a non-stationary series. auto.arima further determined the values of (p,d,q) to be (4,1,2) with seasonal component (0,1,0)[12]. With this information built an arima model and predicted for the next 24 months.

## Conclusion
Errors were following normal distribution, thus the confidence intervals can be deemed trustworthy.

## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the R script files with comment on each code line so it should be easy to follow along.
