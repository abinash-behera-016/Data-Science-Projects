#Let's load the necessary packages.
library(forecast)
library(stats)
library(ggplot2)

#We'll use the dataframe 'rain' for this part of the exercise.
#Right now, R is treating it as a normal object. 
#We need to convert it to a time series object where order matters. We'll also specify the starting year.
raints = ts(rain, start = c(1813))

#Let's see how the data changes over the years.
plot(raints)

#Clearly, this data doesn't have any linear trend or seasonality.
#We'll use HoltWinters function to create an exponential smoothing model which is the most basic model.
#HW function has 3 parameters, alpha (weightage to most recent values), beta (linear trend), gamma (seasonality).
#We'll be setting beta and gamma to be false, obviously.
rainforecast = HoltWinters(raints, beta = F, gamma = F)
rainforecast

#HoltWinters determines alpha to be 0.02412151 by some trial error optimasation.
#Let's plot rainforecast.
plot(rainforecast)

#We can use our own value of alpha. Let's use a much higher value 0.4
rainforecast2 = HoltWinters(raints, alpha = 0.4, beta = F, gamma = F)
rainforecast2
plot(rainforecast2)

#Now our forecast line looks more like the actual graph as high alpha means more weightage to recent values.
#Let's build model for the next 10 years using forecast package.
r2forecast = forecast(rainforecast, h = 10)
r2forecast
plot(r2forecast)

#For the model to be adequate, our errors should be independent. We'll use the auto-correlation plot.
acf(r2forecast$residuals)

#At first, the plot doesn't appear, saying there are missing values.
#We look for missing values and residual has it's first value as NA. We ignore it and then plot acf.
r2forecast$residuals <- na.omit(r2forecast$residuals)
acf(r2forecast$residuals)
#No auto-correlation bars are above the blue line.

#For the model to have correct Confidence Interval, errors should follow normal distribution.
d = data.frame(x = as.vector(r2forecast$residuals))
ggplot(d, aes(x = x)) + geom_density(color = "red") + stat_function(fun = dnorm, aes(x =x), colour = "green")
#Clearly, errors are not following normal distribution. Thus, we should be aware and not fully trust the confidence intervals.


#Now let's look at data where there's linear trend but no seasonality. We'll use 'skirts.csv'.
skirts = ts(skirts, start = c(1866))
plot(skirts)

#Clearly, this data has some linear trend and we can't put beta = F.
skirtforecast = HoltWinters(skirts, gamma = F)
skirtforecast
plot(skirtforecast)

#Here, the forecast equation is a + b*h = 529.308585 + 5.690464*h.
#The model is quite sensitive to changes in recent trends here, so it doesn't make sense to predict too far into the future.
skirtfuture = forecast(skirtforecast, h = 19)
skirtfuture
plot(skirtfuture)

#Model adequacy check.
skirtfuture$residuals <- na.omit(skirtfuture$residuals)
acf(skirtfuture$residuals, lag.max = 20)
#The plot suggests that there might be some auto-correlation present as one or two vertical lines go beyond the blue line.

#We'll use box-ljung test to see whether they are significant or not.
Box.test(skirtfuture$residuals, lag = 20, type = c("Ljung-Box"))
#High p-value (0.4749 > 0.05) suggests that there's no significant correlation.

#Confidence Interval correctness check.
d = data.frame(x = as.vector(skirtfuture$residuals))
ggplot(d, aes(x = x)) + geom_density(color = "red") + stat_function(fun = dnorm, aes(x = x), colour = "green")
#Clearly, errors are not following normal distribution.Thus, we should be aware and not fully trust the confidence intervals.


#Next let's look at data with both linear trend and seasonality.
#Seasonality means that a patternrepeats periodically. Thus, we provide that period by 'frequency' argument.
#Also, we need to provide whenn the period starts. Below, the period starts from 1987, January.
souvenirts = ts(souvenir, frequency = 12, start = c(1987, 1))
plot(souvenirts)

#The plot suggests that the effect of seasonality is multiplicative i.e, amplitude for any month increases over time.
#Here, there's a peak in December every year, but the amplitutde of the peak is increasing year by year.
#Further, the effect of seasonality is not constant. We take care of this by taking logarithm.
souvenirts = log(souvenirts)
plot(souvenirts)

#Let's model the data using HoltWinters.
souvenirforecast = HoltWinters(souvenirts)
souvenirforecast
#Beta comes out to be 0 which makes sense as there's constant trend over time. No need to give weightage to recent most trends.
#Gamma comes out be 0.9561275 suggesting there's a strong seasonal effect in the data.

#Let's build the predictive model for the next 48 terms.
souvenirfuture = forecast(souvenirforecast, h = 48)
plot(souvenirfuture)

#Adequecy test.
souvenirfuture$residuals <- na.omit(souvenirfuture$residuals)
acf(souvenirfuture$residuals, lag.max = 20)

#Shapira-Wilk Normality test.
shapiro.test(souvenirfuture$residuals)
#W(0 to 1) has a very high value of 0.98618, suggesting the residuals(errors) follow a normal distribution.
#High p-value (0.6187>0.05) means we failed to reject or favour the null hypothesis i.e, "Erros follow normal distribution".

#Now we look at more general models which do not take alpha, beta and gamma into account.
#AR(Auto-Regressive), MA(Moving Average), ARIMA(Auto-Regressive Integrated Moving Average), SARIMA(Seasonal ARIMA)
#These models assume that data values depend on the last p-value only.
auto.arima(souvenirts)
#This turns out to be a SARIMA model with the values of (p, d, q)(P, D, Q)[m] to be (2, 0, 0)(0, 1, 1)[12]
#p = number of lagged observations used to predict the current value
#d = number of times the raw observations are differenced to make the time series stationary. 
#q = number of past prediction errors included in the model.
#m = no of periods in a season, only present if seasonality is presesnt.
#P, D, Q = same as above but respective seasonal parameters.

#Based on these values let's create the ARIMA model.
arimafit = arima(souvenirts, order = c(2,0,0), seasonal = c(0,1,1))
arimafuture = forecast(arimafit, h = 48)
plot(arimafuture)

#Adequecy test
acf(arimafuture$residuals, lag.max = 20)

#Normality test
shapiro.test(arimafuture$residuals)