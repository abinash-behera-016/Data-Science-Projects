#Load the necessary packages
library(car)
library(dplyr)
library(ggplot2)

#Check for the presence of any categorical variables
glimpse(bicycle_train)

#Let's build the model using train data. The we'll check the performance of the model on test data.
fit_cycle = lm(cnt~.-holiday -temp -weathersit_1 -season_2, data = bicycle_train)

sort(vif(fit_cycle), decreasing = T) [1:5]

#Error "there are aliased coefficients in the model" comes up. This model has multicollinearity.
#It means two or more predictors are perfectly correlated.
#To fix this, we find those variables. We can use alias() or cor() to create a correlation matrix for the variables.

alias(fit_cycle)

#Let's run
fit_cycle = stats::step(fit_cycle)
summary(fit_cycle)

#This is our final model formula. Adjusted R-sq value = 1
#We can check the variation visually by plotting a graph between original cnt values and predicted cnt values.
#We first create a new column containing predicted cnt values.
bicycle_test = bicycle_test %>% mutate(predicted_cnt = predict(fit_cycle, newdata = bicycle_test))
ggplot(bicycle_test, aes(x = cnt, y = predicted_cnt)) + geom_point(alpha = 0.5)

#A good overlap suggests that it's good model.

#Let's look the the back-end linear equation's co-efficients.
fit_cycle$coefficients

#Residual~fitted plot. The red line should be as horizontal as possible, suggesting a true linear relation.
plot(fit_cycle, which = 1)

#To check whether residuals follow normal distributions or not.
plot(fit_cycle, which = 2)

#Shapiro-Wilk Normality Test
shapiro.test(fit_cycle$residuals)

#Homoscedastic Test
plot(fit_cycle, which = 3)

#Cook's Distance Test. The values along Y-axis should not exceed 1.
#If some observation's C-distance exceeds 1, that translates to extreme influence of that obs on the model.
#That observation should be removed manually.
plot(fit_cycle, which = 4)

#We calculate RMSE on test data.
rmse = mean((bicycle_test$cnt - predict(fit_cycle, newdata = bicycle_test))**2) %>% sqrt()
rmse

#Let's calculate RMSLE(Root Mean Squared Logarithmic Error), which a more generalized evaluation metric.
sqrt(mean((log(bicycle_test$predicted_cnt + 1) - log(bicycle_test$cnt + 1))^2)) #7.117529e-15

#Let's calculate MAPE(Mean Absolute Percentage Error)
mean(abs((bicycle_test$cnt - bicycle_test$predicted_cnt) / bicycle_test$cnt)) * 100 #1.354731e-13








#Custom function example for RMSLE
rmsle <- function(actual, predicted) {
  sqrt(mean((log(predicted + 1) - log(actual + 1))^2))
}
