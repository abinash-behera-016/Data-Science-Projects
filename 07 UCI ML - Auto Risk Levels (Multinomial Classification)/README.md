This is a dataset from UCI Machine Learning repository. This data set consists of three types of entities: (a) the specification of an auto in terms of various characteristics, (b) its assigned insurance risk rating, (c) its normalized losses in use as compared to other cars.  The second rating corresponds to the degree to which the auto is more risky than its price indicates. Cars are initially assigned a risk factor symbol associated with its price.   Then, if it is more risky (or less), this symbol is adjusted by moving it up (or down) the scale.  Actuarians call this process "symboling".  A value of +3 indicates that the auto is risky, -3 that it is probably pretty safe.
The third factor is the relative average loss payment per insured vehicle year.  This value is normalized for all autos within a particular size classification (two-door small, station wagons, sports/speciality, etc...), and represents the average loss per car per year.

# Predicting Risk Level of an Automobile

## Project Overview
This project aims to predict the risk level of different cars into seven categories: -3 to 3. The classification models built in this project uses various physical, techincal and financial features to make predictions.

## Dataset Description
The dataset contains several attributes related to the individuals' demographic and financial details. Here is a brief overview of the columns in the dataset:
Here are the column descriptions for the "automobile" dataset:

- `symboling`: _numeric_: Level of risk associated with the automobile from an insurance company's perspective. Ranges from -3 to 3, with higher values indicating higher risk.
- `normalized_losses`: _character_: Normalized losses for the automobile.
- `make`: _character_: Manufacturer of the automobile.
- `fuel_type`: _character_: Type of fuel used by the automobile (e.g., gas, diesel).
- `aspiration`: _character_: Type of aspiration used in the automobile (e.g., std, turbo).
- `num_of_doors`:  _character_:Number of doors on the automobile.
- `body_style`: _character_: Body style of the automobile.
- `drive_wheels`: _character_: Drive wheels configuration (e.g., fwd, rwd, 4wd).
- `engine_location`: _character_: Location of the engine in the automobile (e.g., front, rear).
- `wheel_base`: _numeric_: Wheelbase of the automobile.
- `length`: _numeric_: Length of the automobile.
- `width`: _numeric_: Width of the automobile.
- `height`: _numeric_: Height of the automobile.
- `curb_weight`: _numeric_: Curb weight of the automobile.
- `engine_type`: _character_: Type of engine used in the automobile.
- `num_of_cylinders`:  _character_:Number of cylinders in the engine.
- `engine_size`: _numeric_: Size of the engine.
- `fuel_system`: _character_: Fuel system used in the automobile.
- `bore`: _numeric_: Bore of the engine.
- `stroke`: _numeric_: Stroke of the engine.
- `compression_ratio`: _numeric_: Compression ratio of the engine.
- `horsepower`: _numeric_: Horsepower of the engine.
- `peak_rpm`: _numeric_: _numeric_: Peak revolutions per minute of the engine.
- `city_mpg`: _numeric_: Miles per gallon (MPG) in the city.
- `highway_mpg`: _numeric_: Miles per gallon (MPG) on the highway.
- `price`: _character_: Price of the automobile.

## Objectives
- To develop predictive models that accurately classify automobiles into seven risk levels based on their physical, technical and financial information.
- To identify key factors that significantly influence an automobile's insurance risk level.

## Tools and Technologies Used
- Programming Language/Platform: R, RStudio
- Libraries and Packages: dplyr, ggplot2, cvTools, nnet, car, caret, pROC

## Model Development
- __Data Preparation__: The columns 'make','aspiration','body_style','drive_wheels','engine_location','engine_type','fuel_system', 'fuel_type' were of chr type,so converted them into dummies. Further, the columns 'normalized_losses', 'peak_rpm', 'bore', 'horsepower', 'stroke', 'price' had NAs so imputed mean to remove NAs. Then split the whole data into train and test. 
- __Logistic Regression__: Used multinomial logistic regression using nnet package to build the predictive model.Finalized my model and predicted for the test data.
- __XGBoost__: Then, used rxgboost algorithm with manual hyper parameter tuning to arrive at the best parameter values. Then built the multiclass model and performed prediction on test data.

## Conclusions
The multinomial logistic regression algorithm predicted the target variable with an auc of 0.89 which was further enhanced by random forest with an auc of 0.94.

## How to Run the Project
You'll need RStudio and the above mentioned packages installed. I've also provided the R script files with comment on each code line so it should be easy to follow along.
