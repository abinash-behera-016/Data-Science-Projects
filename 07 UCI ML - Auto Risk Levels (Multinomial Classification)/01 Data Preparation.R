#Load rhe necessary packages
library(randomForest)
library(xgboost)
library(dplyr)
library(ggplot2)
library(cvTools)
library(xgboost)
library(randomForest)
library(car)
#Load the necessary libraries
library(createDummies)
library(caret)
library(pROC)


#We'll use the automobiles dataset. We'll be predicting the target column symboling.
glimpse(automobiles)

automobiles$symboling <- factor(automobiles$symboling)

#We'll create dummies for the columns make, fuel_type, aspiration, body_style, drive_wheels, engine_location, engine_type, fuel_system.
for_dummy_vars = c('make','aspiration','body_style','drive_wheels','engine_location','engine_type','fuel_system', 'fuel_type')


for(var in for_dummy_vars){
  automobiles = createDummies(automobiles,var,5)
}

#We'll remove ? and impute mean in the columns normalized_losses, peak_rpm, bore, horsepower, stroke, price.
to_numeric_cols = c('normalized_losses', 'peak_rpm', 'bore', 'horsepower', 'stroke', 'price')

for (col in to_numeric_cols) {
    automobiles[[col]] <- as.numeric(replace(as.character(automobiles[[col]]), automobiles[[col]] == '?', NA))
    mean_value <- mean(automobiles[[col]], na.rm = TRUE)
    automobiles[[col]][is.na(automobiles[[col]])] <- mean_value
}


#For num_of_cylinders and num_of_doors, we'll convert text data to numbers.
#First we'll define a mapping from chr to numeric and then apply the map.
# Mapping from words to numbers
cylinder_mapping <- c("two" = 2, "three" = 3, "four" = 4, "five" = 5, "six" = 6, "eight" = 8, "twelve" = 12)
automobiles <- automobiles %>% mutate(num_of_cylinders = purrr::map_dbl(num_of_cylinders, ~ cylinder_mapping[[.]]))

door_mapping <- c("two" = 2, "?" = 3, "four" = 4)
automobiles <- automobiles %>% mutate(num_of_doors = purrr::map_dbl(num_of_doors, ~ door_mapping[[.]]))

#Check for NAs
sum(is.na(automobiles))

#Let's break the data into train and test data.
set.seed(77)
s = sample(1:nrow(automobiles), 0.8 * nrow(automobiles))
automobiles_train = automobiles[s, ]
automobiles_test = automobiles[-s, ]
