#Load the necessary packages
library(tidymodels)
library(visdat)
library(tidyr)
library(car)
library(pROC)
library(dplyr)
library(ggplot2)
library(tree)
library(randomForest)
library(cvTools)
library(rpart)
library(rpart.plot)

#We'll use loans data.
View(loans_data)
glimpse(loans_data)

#We won't use ID for modelling and will remove it.
loans_data$ID <- NULL

#We'll convert Amount.Funded.By.Investors, Open.CREDIT.Lines and Revolving.CREDIT.Balance to numeric type.
loans_data$amt_investers <- as.numeric(loans_data$Amount.Funded.By.Investors)
loans_data$open_clines <- as.numeric(loans_data$Open.CREDIT.Lines)
loans_data$revolving_cred <- as.numeric(loans_data$Revolving.CREDIT.Balance)

loans_data$Amount.Funded.By.Investors <- NULL
loans_data$Open.CREDIT.Lines <- NULL
loans_data$Revolving.CREDIT.Balance <- NULL

#Let's convert Interest.Rate and Debt.To.Income.Ratio to numeric by removing the % symbol.
loans_data <- loans_data %>% mutate(Interest.Rate = as.numeric(gsub("%", "", Interest.Rate)))
loans_data <- loans_data %>% mutate(Debt.To.Income.Ratio = as.numeric(gsub("%", "", Debt.To.Income.Ratio)))

#we'll convert FICO.Range to numeric by taking mean of the upper and lower limit.
loans_data = loans_data %>% mutate(f1 = as.numeric(substr(FICO.Range, 1, 3)),
                                   f2 = as.numeric(substr(FICO.Range, 5, 7)),
                                   fico = (f1+f2)/2) %>% select(-f1, -f2, -FICO.Range)


#Now we'll create dummies. So now it's time to clean up any NAs.
sum(is.na(loans_data)) #33 NAs
loans_data <- loans_data[complete.cases(loans_data), ] #26 rows removed

#Let's create a custom function to create dummies.
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

#Let's set the column names we want dummies for and create dummies using the customfunction we created earlier. 
for_dummy_vars=c('Home.Ownership','Employment.Length', 'State','Loan.Purpose', 'Loan.Length')

for(var in for_dummy_vars){
  loans_data=CreateDummies(loans_data,var,50)
}

glimpse(loans_data)

#Let's break the data into test and train data.
set.seed(44)
s = sample(1:nrow(loans_data), 0.8*nrow(loans_data))
loans_train = loans_data[s, ]
loans_test = loans_data[-s, ]