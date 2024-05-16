#Load the necessary packages
library(tidymodels)
library(tidyr)
library(dplyr)
library(ggplot2)

#We'll use bicycle data for this project.
glimpse(bicycle_data)
View(bicycle_data)

#Let's check for any NAs.
sum(is.na(bicycle_data)) #No NAs

#We do know need the dteday column and we'll remove it.
bicycle_data$dteday <- NULL

#instant
table(bicycle_data$instant) #Seems like a row number kind of thing. We'll remove that too.
bicycle_data$instant <- NULL

#We'll create dummies from season, mnth, weekday, weathersit columns. 
for_dummy_vars = c('season','mnth', 'weekday','weathersit')

#Custom function to create dummies. Always remember to adjust cutoff based on the dataset row number.
CreateDummies=function(data,var,freq_cutoff=15){
  t=table(data[,var])
  t=t[t>freq_cutoff]
  t=sort(t)
  categories=names(t)[-1]
  
  for( cat in categories){
    name=paste(var,cat,sep="_")
    name=gsub(" ","",name)
    name=gsub("-","_",name)
    name=gsub("\\?","Q",name)
    name=gsub("<","LT_",name)
    name=gsub("\\+","",name)
    name=gsub(">","GT_",name)
    name=gsub("=","EQ_",name)
    name=gsub(",","",name)
    name=gsub("/","_",name)
    data[,name]=as.numeric(data[,var]==cat)}
  data[,var]=NULL
  return(data)}

#Let's create dummies using the custom function we created earlier. 
for(var in for_dummy_vars){
  bicycle_data=CreateDummies(bicycle_data,var,15)}

#A final check for NAs
sum(is.na(bicycle_data)) #No NAs

#Let's break the data into train and test data.
set.seed(22)
s = sample(1:nrow(bicycle_data), 0.7*nrow(bicycle_data))
bicycle_train = bicycle_data[s, ]
bicycle_test = bicycle_data[-s, ]

View(bicycle_train)
View(bicycle_test)