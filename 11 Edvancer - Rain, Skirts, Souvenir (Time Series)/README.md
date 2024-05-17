These were a set of time series projects given by our instructor at Edavncer during the course period while we were studying Time Series Analysis. This project consisted of three datasets.
- `rain.csv`: Rainfall data with no linear trend or seasonality
- `skirts.csv`: Unspecified data with linear trend but no seasonlity
- `souvenir.csv`:  Unspecified data with linear trend alnd also seasonlity


# 01 Rain

## Project Overview
This project aims to predict the amount of rainfall in the coming years based on previous year rainfall information.

## Dataset Description
The dataset contains only the rainfall amount in one column. Here is a brief overview of that columns in the dataset:
- `x` : _numeric_: Amount of rainfall

## Objectives
- To develop a predictive model that accurately predicts the amount of rainfall in the coming years based on previous year rainfall information.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: forecast, ggplot2, stats

## Model Development
- __Data Preparation__: The columns 'x' was already in the numeric format. Just converted it to a time series object starting from the year 1813 as suggested by our instructor.
- __HoltWinters__: Initial plots suggested there was no linear trend (beta) or seasonality (gamma). Built a forecast model using the HoltWinters algorithm with beta = F and gamma = F which determined the value of alpha (weightage to most recent values) to be 0.02412151. Then used a much higher value of alpha = 0.4 and saw a much better fit of the model with the actual data. Predicted 10 Years into the future

## Conclusions
Used the HoltWinters model to predict for the next 10 years. The errors were not following normal distribution so concluded that it would not be wise to follow confidence interval of predictions blindly.




# 02 Skirts

## Project Overview
This project aims to predict information in the coming years based on previous year data.

## Dataset Description
The dataset contains only one column. Here is a brief overview of that columns in the dataset:
- `x` : _numeric_: Unspecified time series information

## Objectives
- To develop a predictive model that accurately predicts for the coming years based on previous year information with linear trend.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: forecast, ggplot2, stats

## Model Development
- __Data Preparation__: The columns 'x' was already in the numeric format. Just converted it to a time series object starting from the year 1866 as suggested by our instructor.
- __HoltWinters__: Initial plots suggested there was a linear trend (beta) but no seasonality (gamma). Built a forecast model using the HoltWinters algorithm with gamma = F which determined the value of alpha = 529.308585 and beta = 5.690464. Extremely high alpha value suggested importance of the most recent value. Not recemmended to predict too far into the future.

## Conclusions
Used the HoltWinters model to predict for the next 19 years. The errors were not following normal distribution so concluded that it would not be wise to follow confidence interval of predictions blindly.




# 03 Souvenirs

## Project Overview
This project aims to predict information in the coming years based on previous year data.

## Dataset Description
The dataset contains only one column. Here is a brief overview of that columns in the dataset:
- `x` : _numeric_: Unspecified time series information

## Objectives
- To develop a predictive model that accurately predicts for the coming years based on previous year information with linear trend.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: forecast, ggplot2, stats

## Model Development
- __Data Preparation__: The columns 'x' was already in the numeric format. Just converted it to a time series object starting from the year 1987, January as suggested by our instructor.
- __HoltWinters__: Initial plots suggested there was a linear trend (beta) and seasonality (gamma). Built a forecast model using the HoltWinters algorithm which determined the value of gamma = 0.9561275. Extremely high gamma value suggested importance of seasonality.
## Conclusions
Used the HoltWinters model to predict for the next 48 terms. The errors were following normal distribution so concluded that the confidence interval of prediction are trustworthy.




## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the R script files with comment on each code line so it should be easy to follow along.
