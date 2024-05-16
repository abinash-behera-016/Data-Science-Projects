#Let's load the necessary packages.
library(car)
library(dplyr)
library(ggplot2)
library(caret)

##Let's build our model on the practice train data.
fit_housing_practice = lm(SalePrice~. -Id, data = hprice_train_practice)

sort(vif(fit_housing_practice), decreasing = T) [1:5]

#Let's correct the formula with removing aliased variables and then remove based on vif.
alias(fit_housing_practice)

fit_housing_practice = lm(SalePrice~. -Id -GarageQual_None -GarageCond_None -GrLivArea -GarageFinish_Unf 
                          -BldgType_1Fam -Exterior1st_VinylSd -Exterior1st_MetalSd -Exterior2nd_CmentBd
                          -BsmtFinType1_Unf -BsmtExposure_No -TotalBsmtSF -BsmtCond_TA -SaleType_New
                          -BsmtQual_Gd -KitchenQual_Gd -SecondFlrSF -ExterQual_TA, data = hprice_train_practice)

sort(vif(fit_housing_practice), decreasing = T) [1:5]

#Let's predict for the validation data.
hprice_lm_pred = data.frame(Real_Price = hprice_val_practice$SalePrice,
                            Predicted_Price = predict(fit_housing_practice, newdata = hprice_val_practice))

#Let's calculate RMSE.
RMSE(hprice_lm_pred$Predicted_Price, hprice_lm_pred$Real_Price) #26562.25



##Let's build our final model on the test data.
fit_housing = lm(SalePrice~. -Id, data = hprice_train)

sort(vif(fit_housing), decreasing = T) [1:5]

#Let's correct the formula with removing aliased variables and then remove based on vif.
alias(fit_housing)

fit_housing = lm(SalePrice~. -Id -GarageQual_None -GarageCond_None -GrLivArea -GarageFinish_Unf 
                 -BldgType_1Fam -Exterior1st_VinylSd -Exterior1st_MetalSd -Exterior2nd_CmentBd
                 -BsmtFinType1_Unf -BsmtExposure_No -TotalBsmtSF -BsmtCond_TA -SaleType_New
                 -BsmtQual_Gd -KitchenQual_Gd -SecondFlrSF -ExterQual_TA, data = hprice_train)

sort(vif(fit_housing), decreasing = T) [1:5]

#Let's predict for the test data.
submission_housing_price_lm = data.frame(Id = hprice_test$Id, SalePrice = predict(fit_housing, newdata = hprice_test))
View(submission_housing_price_lm)

#Export to csv.
write.csv(submission_housing_price_lm, "submission_housing_price_lm.csv", row.names = F)