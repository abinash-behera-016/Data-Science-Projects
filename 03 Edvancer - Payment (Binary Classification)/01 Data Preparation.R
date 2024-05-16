#Load the necessary packages
library(dplyr)
library(ggplot2)

#We'll work the payday_collection imported as pday.
glimpse(pday)

#Check for NAs
sum(is.na(pday)) #None

#payment is the response column and it has values 'Success' and 'Denied'. We'll convert those into 1s and 0s.
table(pday$payment)
pday = pday %>% mutate(payment_bin = as.numeric(payment == "Success"))
pday$payment <- NULL

#We'll create dummies for the following chr columns. 
for_dummy_vars = c('var1','var2', 'var9','var10', 'var11', 'var13', 'var17', 'var19', 'var23', 'var29')

#Custom function to create dummies. Always remember to adjust cutoff based on the dataset row number.
CreateDummies=function(data,var,freq_cutoff=500){
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
  pday=CreateDummies(pday,var,500)}

#A final check for NAs
sum(is.na(pday)) #No NAs

#Let's break the data into test and train.
set.seed(12)
s = sample(1:nrow(pday), 0.8*nrow(pday))
pday_train = pday[s, ]
pday_test = pday[-s, ]

#A final NA check
sum(is.na(pday_train))
sum(is.na(pday_test))