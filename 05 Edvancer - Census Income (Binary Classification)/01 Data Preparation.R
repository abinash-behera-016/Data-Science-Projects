#Let's load the necessary packages.
library(dplyr)
library(fastDummies)
library(caret)
library(ggplot2)

#We'll use census income dataset to predict the targey Y which containing two income groups.
glimpse(census_income)

#We'll convert the target variable Y having two groups <=50K, >50K to binary numeric format first.
table(census_income$Y)
census_income = census_income %>% mutate(Y = as.numeric(Y == '>50K'))

#Check for NAs
sum(is.na(census_income))

#We'll create dummies for workclass, education, marital.status, occupation, relationship, race, native.country.
for_dummy_vars=c('workclass','education', 'marital.status','relationship', 'race', 'native.country', 'occupation', 'sex')

#Let's create a function that will create dummies for each column.
CreateDummies=function(data,var,freq_cutoff){
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
    data[,name]=as.numeric(data[,var]==cat)
  }
  
  data[,var]=NULL
  return(data)
} 

for(var in for_dummy_vars){
  census_income = CreateDummies(census_income,var,500)
}

#Let's break the data into train and test data.
set.seed(55)
s = sample(1:nrow(census_income), 0.8 * nrow(census_income))
census_train = census_income[s, ]
census_test = census_income[-s, ]