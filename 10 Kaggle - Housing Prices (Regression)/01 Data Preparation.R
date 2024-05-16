#Let's load the necessary packages.
library(dplyr)
library(createDummies)
library(ggplot2)

#We'll be using housing_price train data imported as hprice_train to build our model for the target 'SalePrice'.
glimpse(hprice_train)

#Let's check for NAs.
sapply(hprice_train, function(x) sum(is.na(x)))

#The columns LotFrontage, Alley, MasVnrType, MasVnrArea, BsmtQual, BsmtCond, BsmtExposure, BsmtFinType1, BsmtFinType2, Electrical,
#FireplaceQu, Fence, GarageType, GarageYrBlt, GarageFinish, GarageQual, GarageCond, PoolQC, MiscFeature have NAs. 
#They'll be dealt separately and accordingly.

#Out of the numeric NA columns, we'll impute mean for LotFrontage as NA and impute current year in GarageYrBlt.
#We'll impute 0 for NAs in MasVnrArea as NAs here represent no Masonry veneer area.
hprice_train$LotFrontage[is.na(hprice_train$LotFrontage)] <- mean(hprice_train$LotFrontage, na.rm = TRUE)
hprice_train$GarageYrBlt[is.na(hprice_train$GarageYrBlt)] <- 2024
hprice_train$MasVnrArea[is.na(hprice_train$MasVnrArea)] <- 0

#The chr columns, Alley, MasVnrType, BsmtQual, BsmtCond, BsmtExposure, BsmtFinType1, BsmtFinType2, Electrical, FireplaceQu, Fence, 
#GarageType, GarageFinish, GarageQual, GarageCond, PoolQC, MiscFeature have NAs.
#From the data description file, NA in these columnsmeans that partuclar feature in not available at all.
#For example, NA in Fence means no fence is available around that house. So we'll impute 'None' for NAs in these columns.]
hprice_train$Alley[is.na(hprice_train$Alley)] <- 'None'
hprice_train$MasVnrType[is.na(hprice_train$MasVnrType)] <- 'None'
hprice_train$BsmtQual[is.na(hprice_train$BsmtQual)] <- 'None'
hprice_train$BsmtCond[is.na(hprice_train$BsmtCond)] <- 'None'
hprice_train$BsmtExposure[is.na(hprice_train$BsmtExposure)] <- 'None'
hprice_train$BsmtFinType1[is.na(hprice_train$BsmtFinType1)] <- 'None'
hprice_train$BsmtFinType2[is.na(hprice_train$BsmtFinType2)] <- 'None'
hprice_train$Electrical[is.na(hprice_train$Electrical)] <- 'None'
hprice_train$FireplaceQu[is.na(hprice_train$FireplaceQu)] <- 'None'
hprice_train$Fence[is.na(hprice_train$Fence)] <- 'None'
hprice_train$GarageType[is.na(hprice_train$GarageType)] <- 'None'
hprice_train$GarageFinish[is.na(hprice_train$GarageFinish)] <- 'None'
hprice_train$GarageQual[is.na(hprice_train$GarageQual)] <- 'None'
hprice_train$GarageCond[is.na(hprice_train$GarageCond)] <- 'None'
hprice_train$PoolQC[is.na(hprice_train$PoolQC)] <- 'None'
hprice_train$MiscFeature[is.na(hprice_train$MiscFeature)] <- 'None'

#There are some columns YearBuilt, YearRemodAdd, GarageYrBlt, YrSold which contain year values.
#We should subtract them from current year and find age, to convey the information of years passed since then.
hprice_train = hprice_train %>% mutate(house_age = 2024 - YearBuilt) %>% select(-YearBuilt)
hprice_train = hprice_train %>% mutate(remodel_age = 2024 - YearRemodAdd) %>% select(-YearRemodAdd)
hprice_train = hprice_train %>% mutate(garage_age = 2024 - GarageYrBlt) %>% select(-GarageYrBlt)
hprice_train = hprice_train %>% mutate(sold_age = 2024 - YrSold) %>% select(-YrSold)

#Now we'll create dummies for the chr columns MSZoning, Street, Alley, LotShape, LandContour, Utilities, , , , , , , , , , , 
#Let's print the chr column names for which we'll create dummies.
names(hprice_train)[sapply(hprice_train, is.character)]

for_dummy_vars = c('MSZoning', 'Street', 'Alley', 'LotShape', 'LandContour', 'Utilities', 'LotConfig', 'LandSlope',
                   'Neighborhood', 'Condition1', 'Condition2', 'BldgType', 'HouseStyle', 'RoofStyle', 'RoofMatl', 'Exterior1st',
                   'Exterior2nd', 'MasVnrType', 'ExterQual', 'ExterCond', 'Foundation', 'BsmtQual', 'BsmtCond', 'BsmtExposure',
                   'BsmtFinType1', 'BsmtFinType2', 'Heating', 'HeatingQC', 'CentralAir', 'Electrical', 'KitchenQual', 'Functional',
                   'FireplaceQu', 'GarageType', 'GarageFinish', 'GarageQual', 'GarageCond', 'PavedDrive', 'PoolQC', 'Fence',
                   'MiscFeature', 'SaleType', 'SaleCondition')

for(var in for_dummy_vars){
  hprice_train = createDummies(hprice_train,var, 25)}

#Let's apply the same data preparation steps for the test data too, with some modifications which have been marked as 'new'
#I didn't bind train & test data to prepare as they're from a hackathon, so the submission needs to have the same rows as the test data.
hprice_test$LotFrontage[is.na(hprice_test$LotFrontage)] <- mean(hprice_test$LotFrontage, na.rm = TRUE)
hprice_test$BsmtFinSF1[is.na(hprice_test$BsmtFinSF1)] <- mean(hprice_test$BsmtFinSF1, na.rm = TRUE) #new
hprice_test$BsmtFinSF2[is.na(hprice_test$BsmtFinSF2)] <- mean(hprice_test$BsmtFinSF2, na.rm = TRUE)#new
hprice_test$TotalBsmtSF[is.na(hprice_test$TotalBsmtSF)] <- mean(hprice_test$TotalBsmtSF, na.rm = TRUE) #new
hprice_test$BsmtUnfSF[is.na(hprice_test$BsmtUnfSF)] <- mean(hprice_test$BsmtUnfSF, na.rm = TRUE) #new
hprice_test$BsmtFullBath[is.na(hprice_test$BsmtFullBath)] <- mean(hprice_test$BsmtFullBath, na.rm = TRUE) #new
hprice_test$BsmtHalfBath[is.na(hprice_test$BsmtHalfBath)] <- mean(hprice_test$BsmtHalfBath, na.rm = TRUE) #new
hprice_test$GarageCars[is.na(hprice_test$GarageCars)] <- mean(hprice_test$GarageCars, na.rm = TRUE)
hprice_test$GarageArea[is.na(hprice_test$GarageArea)] <- mean(hprice_test$GarageArea, na.rm = TRUE)
hprice_test$GarageYrBlt[is.na(hprice_test$GarageYrBlt)] <- 2024
hprice_test$MasVnrArea[is.na(hprice_test$MasVnrArea)] <- 0

hprice_test$KitchenQual[is.na(hprice_test$KitchenQual)] <- mode(hprice_test$BsmtUnfSF) #new
hprice_test$Exterior1st[is.na(hprice_test$Exterior1st)] <- mode(hprice_test$Exterior1st) #new
hprice_test$Exterior2nd[is.na(hprice_test$Exterior2nd)] <- mode(hprice_test$Exterior2nd) #new
hprice_test$MSZoning[is.na(hprice_test$MSZoning)] <- 'None'
hprice_test$Alley[is.na(hprice_test$Alley)] <- 'None'
hprice_test$MasVnrType[is.na(hprice_test$MasVnrType)] <- 'None'
hprice_test$BsmtQual[is.na(hprice_test$BsmtQual)] <- 'None'
hprice_test$BsmtCond[is.na(hprice_test$BsmtCond)] <- 'None'
hprice_test$BsmtExposure[is.na(hprice_test$BsmtExposure)] <- 'None'
hprice_test$BsmtFinType1[is.na(hprice_test$BsmtFinType1)] <- 'None'
hprice_test$BsmtFinType2[is.na(hprice_test$BsmtFinType2)] <- 'None'
hprice_test$Electrical[is.na(hprice_test$Electrical)] <- 'None'
hprice_test$FireplaceQu[is.na(hprice_test$FireplaceQu)] <- 'None'
hprice_test$Fence[is.na(hprice_test$Fence)] <- 'None'
hprice_test$GarageType[is.na(hprice_test$GarageType)] <- 'None'
hprice_test$GarageFinish[is.na(hprice_test$GarageFinish)] <- 'None'
hprice_test$GarageQual[is.na(hprice_test$GarageQual)] <- 'None'
hprice_test$GarageCond[is.na(hprice_test$GarageCond)] <- 'None'
hprice_test$PoolQC[is.na(hprice_test$PoolQC)] <- 'None'
hprice_test$MiscFeature[is.na(hprice_test$MiscFeature)] <- 'None'
hprice_test$Utilities[is.na(hprice_test$Utilities)] <- 'None' #new
hprice_test$SaleType[is.na(hprice_test$SaleType)] <- 'Oth' #new
hprice_test$Functional[is.na(hprice_test$Functional)] <- 'Type' #new

hprice_test = hprice_test %>% mutate(house_age = 2024 - YearBuilt) %>% select(-YearBuilt)
hprice_test = hprice_test %>% mutate(remodel_age = 2024 - YearRemodAdd) %>% select(-YearRemodAdd)
hprice_test = hprice_test %>% mutate(garage_age = 2024 - GarageYrBlt) %>% select(-GarageYrBlt)
hprice_test = hprice_test %>% mutate(sold_age = 2024 - YrSold) %>% select(-YrSold)

for_dummy_vars = c('MSZoning', 'Street', 'Alley', 'LotShape', 'LandContour', 'Utilities', 'LotConfig', 'LandSlope',
                   'Neighborhood', 'Condition1', 'Condition2', 'BldgType', 'HouseStyle', 'RoofStyle', 'RoofMatl', 'Exterior1st',
                   'Exterior2nd', 'MasVnrType', 'ExterQual', 'ExterCond', 'Foundation', 'BsmtQual', 'BsmtCond', 'BsmtExposure',
                   'BsmtFinType1', 'BsmtFinType2', 'Heating', 'HeatingQC', 'CentralAir', 'Electrical', 'KitchenQual', 'Functional',
                   'FireplaceQu', 'GarageType', 'GarageFinish', 'GarageQual', 'GarageCond', 'PavedDrive', 'PoolQC', 'Fence',
                   'MiscFeature', 'SaleType', 'SaleCondition')

for(var in for_dummy_vars){
  hprice_test = createDummies(hprice_test,var, 25)}

#A final check for NAs
sum(is.na(hprice_train)) #No NAs
sum(is.na(hprice_test)) #No NAs

#Let's find the mismatching columns.
setdiff(names(hprice_train), names(hprice_test)) #present in train not in test
setdiff(names(hprice_test), names(hprice_train)) #present in test not in train

#We should remove the mismatching columns from both data, except SalePrice. Removing is fine here as all these columns are dummies.
hprice_train$Condition1_Artery <- NULL
hprice_train$LandContour_Bnk <- NULL
hprice_train$Exterior2nd_WdShng <- NULL
hprice_train$BsmtQual_None <- NULL
hprice_train$Electrical_FuseA <- NULL

hprice_test$BsmtQual_Fa <- NULL
hprice_test$BsmtFinType2_BLQ <- NULL
hprice_test$FireplaceQu_Fa <- NULL
hprice_test$SaleCondition_Abnorml <- NULL

#Further, let's rename the columns 1stFlrSF and 2ndFlrSF as they start with a number which mat cause errors while modelling.
colnames(hprice_train)[colnames(hprice_train) == "2ndFlrSF"] <- "SecondFlrSF"
colnames(hprice_train)[colnames(hprice_train) == "1stFlrSF"] <- "FirstFlrSF"
colnames(hprice_train)[colnames(hprice_train) == "3SsnPorch"] <- "ThreeSsnPorch"

colnames(hprice_test)[colnames(hprice_test) == "2ndFlrSF"] <- "SecondFlrSF"
colnames(hprice_test)[colnames(hprice_test) == "1stFlrSF"] <- "FirstFlrSF"
colnames(hprice_test)[colnames(hprice_test) == "3SsnPorch"] <- "ThreeSsnPorch"

#For practice, let's split train data into train and validation data.
set.seed(123)
s = sample(1:nrow(hprice_train), 0.8*nrow(hprice_train))
hprice_train_practice = hprice_train[s, ]
hprice_val_practice = hprice_train[-s, ]