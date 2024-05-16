This dataset ia a part of a Kaggle competition 'House Prices - Advanced Regression Techniques'

Description: Ask a home buyer to describe their dream house, and they probably won't begin with the height of the basement ceiling or the proximity to an east-west railroad. But this playground competition's dataset proves that much more influences price negotiations than the number of bedrooms or a white-picket fence.
With 79 explanatory variables describing (almost) every aspect of residential homes in Ames, Iowa, this competition challenges you to predict the final price of each home.

# Predicting Housing Prices

## Project Overview
This project aims to predict the prices of residential homes in Iowa. The regression models built in this project uses various physical, geographical, historical and financial features to make predictions.

## Dataset Description
The dataset contains several attributes related to the houses' demographic and financial details. Here is a brief overview of the columns in the dataset:

- `SalePrice`: *numeric* - The property's sale price in dollars. This is the target variable that you're trying to predict.
- `MSSubClass`: *numeric* - The building class.
- `MSZoning`: *character* - The general zoning classification.
- `LotFrontage`: *numeric* - Linear feet of street connected to property.
- `LotArea`: *numeric* - Lot size in square feet.
- `Street`: *character* - Type of road access.
- `Alley`: *character* - Type of alley access.
- `LotShape`: *character* - General shape of property.
- `LandContour`: *character* - Flatness of the property.
- `Utilities`: *character* - Type of utilities available.
- `LotConfig`: *character* - Lot configuration.
- `LandSlope`: *character* - Slope of property.
- `Neighborhood`: *character* - Physical locations within Ames city limits.
- `Condition1`: *character* - Proximity to main road or railroad.
- `Condition2`: *character* - Proximity to main road or railroad (if a second is present).
- `BldgType`: *character* - Type of dwelling.
- `HouseStyle`: *character* - Style of dwelling.
- `OverallQual`: *numeric* - Overall material and finish quality.
- `OverallCond`: *numeric* - Overall condition rating.
- `YearBuilt`: *numeric* - Original construction date.
- `YearRemodAdd`: *numeric* - Remodel date.
- `RoofStyle`: *character* - Type of roof.
- `RoofMatl`: *character* - Roof material.
- `Exterior1st`: *character* - Exterior covering on house.
- `Exterior2nd`: *character* - Exterior covering on house (if more than one material).
- `MasVnrType`: *character* - Masonry veneer type.
- `MasVnrArea`: *numeric* - Masonry veneer area in square feet.
- `ExterQual`: *character* - Exterior material quality.
- `ExterCond`: *character* - Present condition of the material on the exterior.
- `Foundation`: *character* - Type of foundation.
- `BsmtQual`: *character* - Height of the basement.
- `BsmtCond`: *character* - General condition of the basement.
- `BsmtExposure`: *character* - Walkout or garden level basement walls.
- `BsmtFinType1`: *character* - Quality of basement finished area.
- `BsmtFinSF1`: *numeric* - Type 1 finished square feet.
- `BsmtFinType2`: *character* - Quality of second finished area (if present).
- `BsmtFinSF2`: *numeric* - Type 2 finished square feet.
- `BsmtUnfSF`: *numeric* - Unfinished square feet of basement area.
- `TotalBsmtSF`: *numeric* - Total square feet of basement area.
- `Heating`: *character* - Type of heating.
- `HeatingQC`: *character* - Heating quality and condition.
- `CentralAir`: *character* - Central air conditioning.
- `Electrical`: *character* - Electrical system.
- `1stFlrSF`: *numeric* - First Floor square feet.
- `2ndFlrSF`: *numeric* - Second floor square feet.
- `LowQualFinSF`: *numeric* - Low quality finished square feet (all floors).
- `GrLivArea`: *numeric* - Above grade (ground) living area square feet.
- `BsmtFullBath`: *numeric* - Basement full bathrooms.
- `BsmtHalfBath`: *numeric* - Basement half bathrooms.
- `FullBath`: *numeric* - Full bathrooms above grade.
- `HalfBath`: *numeric* - Half baths above grade.
- `Bedroom`: *numeric* - Number of bedrooms above basement level.
- `Kitchen`: *numeric* - Number of kitchens.
- `KitchenQual`: *character* - Kitchen quality.
- `TotRmsAbvGrd`: *numeric* - Total rooms above grade (does not include bathrooms).
- `Functional`: *character* - Home functionality rating.
- `Fireplaces`: *numeric* - Number of fireplaces.
- `FireplaceQu`: *character* - Fireplace quality.
- `GarageType`: *character* - Garage location.
- `GarageYrBlt`: *numeric* - Year garage was built.
- `GarageFinish`: *character* - Interior finish of the garage.
- `GarageCars`: *numeric* - Size of garage in car capacity.
- `GarageArea`: *numeric* - Size of garage in square feet.
- `GarageQual`: *character* - Garage quality.
- `GarageCond`: *character* - Garage condition.
- `PavedDrive`: *character* - Paved driveway.
- `WoodDeckSF`: *numeric* - Wood deck area in square feet.
- `OpenPorchSF`: *numeric* - Open porch area in square feet.
- `EnclosedPorch`: *numeric* - Enclosed porch area in square feet.
- `3SsnPorch`: *numeric* - Three season porch area in square feet.
- `ScreenPorch`: *numeric* - Screen porch area in square feet.
- `PoolArea`: *numeric* - Pool area in square feet.
- `PoolQC`: *character* - Pool quality.
- `Fence`: *character* - Fence quality.
- `MiscFeature`: *character* - Miscellaneous feature not covered in other categories.
- `MiscVal`: *numeric* - Value of miscellaneous feature.
- `Mo
- `Sold`: *numeric* - Month Sold.
- `YrSold`: *numeric* - Year Sold.
- `SaleType`: *character* - Type of sale.
- `SaleCondition`: *character* - Condition of sale.

## Objectives
- To develop predictive models that accurately predict residential home prices based on various physical, geographical, historical and financial features of a home.
- To identify key factors that significantly influence a residential houses' price.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: dplyr, ggplot2, cvTools, xgboost, car, caret, pROC

## Model Development
- __Data Preparation__: The columns age_band, status, occupation, occupation_partner, home_status, family_income, TVArea and a few others were of chr type,so converted them into dummies. Further, converted the target variable to 0 and 1. Then split the whole data into train and test. 
- __Multinomial Logistic Regression__: First, I used Linear Regression to remove variables based on high Variation Inflation Factor (vif) values. Then used binary logistic regression to build the predictive model.Finalized my model and predicted for the test data.
- __Random Forest__: Then, used random forest algorithm with hyper parameter tuning to arrive at the best parameter values. Then built the model and performed prediction on test data.

## Conclusions
The linear regression algorithm predicted on the validation data with an rmse of 26562.25 which was further improved by XGBoost with an rmse of 20457.65. After submitting the test data predictions on Kaggle, got placed on rank 345 out of 5107 participants, on the day of submission.

## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the R script files with comment on each code line so it should be easy to follow along.

You can find the link to the competition [here](https://www.kaggle.com/competitions/house-prices-advanced-regression-techniques).
