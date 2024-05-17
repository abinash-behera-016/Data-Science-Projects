#Let's load the necessary packages.
library(forecast)
library(stats)
library(ggplot2)
library(dplyr)
library(tseries)

#we'll use international_airline_passengers.csv and we'll rename it to int_air for simplicity.
#The row no 145 doesn't contain any information. We should remove that row.
int_air = int_air %>% slice(-145)

#Let's the rename the coloumns.
int_air = int_air %>% rename('no of passengers' = 'International airline passengers: monthly totals in thousands. Jan 49 ? Dec 60')

#Let's convert it to a time series object and plot. (1)
int_air_ts <- ts(int_air$no_of_passengers, start = c(1949, 01), frequency = 12)
plot(int_air_ts)

#There seems to be some linearity and also seasonality. Let's check for any trend or seasonality. (2)
plot(decompose(int_air_ts))

#Let's check for stationarity. (2)
adf.test(int_air_ts, alternative ="stationary", k=12)
#p-value is 0.7807 (>0.05), suggesting it's a non-stationary series.

#Let's make an ARIMA model. (3)
auto.arima(int_air_ts)

#The values of (p,d,q) come out to be (4,1,2) with seasonal component (0,1,0)[12]. Let's build the SARIMA model.
int_air_ts_fit = arima(int_air_ts, order = c(4,1,2), seasonal = c(0,1,0))

#Let's forecast the next 24 months. (4)
int_air_ts_future = forecast(int_air_ts_fit, h = 24, level = 95)
plot(int_air_ts_future)

#Q-Q plot (5)
qqnorm(int_air_ts_future$residuals)
qqline(int_air_ts_future$residuals)

##Let's check for stationarity. (6)
adf.test(int_air_ts, alternative ="stationary", k=12)
#p-value is 0.7807 (>0.05), suggesting it's a non-stationary series.