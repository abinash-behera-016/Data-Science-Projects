#Load the necessary packages
library(tidymodels)
library(visdat)
library(tidyr)
library(car)
library(dplyr)
library(ggplot2)
library(pROC)


#We'll work on the rg_train and rg_test dataset. We load them from respective csv files.
View(rg)
sum(is.na(rg))

#We want to create a model based on rg_train to predict the outcome variable Revenue.Grid in rg_test.
glimpse(rg)


#Now we look at different chr columns and convert them to numeric.
#1 Children. It already has num data. Just have to change 4+ to 4 and replace Zero to 0.
table(rg$children)
rg = rg %>% mutate(children=ifelse(children=="Zero", 0, substr(children, 1, 1)), children=as.numeric(children))

#2 age_band. We take mean of usual age groups, convert 71+ to 71 and impute Unknown with NAs.
table(rg$age_band)
rg = rg %>% filter(age_band != 'Unknown')

rg = rg %>% mutate(a1 = as.numeric(substr(age_band, 1, 2)),
                   a2 = as.numeric(substr(age_band, 4, 5)),
                   age = ifelse(substr(age_band, 1,2)=="71", 71, ifelse(age_band=="Unknown", NA, 0.5*(a1+a2)))) %>%
  select(-a1, -a2, -age_band)

#3 status. We remove Unknown and create 3 dummies.
table(rg$status)
rg = rg %>% filter(status != 'Unknown')
rg = rg %>% mutate(st_div = as.numeric(status=="Divorced/Separated"),
                   st_par = as.numeric(status=="Partner"),
                   st_snm = as.numeric(status=="Single/Never Married")) %>%
  select(-status)

#4 occupation.
table(rg$occupation)
rg = rg %>% mutate(oc_bm = as.numeric(occupation=="Business Manager"),
                   oc_hw = as.numeric(occupation=="Housewife"),
                   oc_mw = as.numeric(occupation=="Manual Worker"),
                   oc_pro = as.numeric(occupation=="Professional"),
                   oc_rtd = as.numeric(occupation=="Retired"),
                   oc_sec = as.numeric(occupation=="Secretarial/Admin"),
                   oc_oth = as.numeric(occupation %in% c("Other", "Unknown"))) %>%
  select(-occupation)

#5 Occupation_partner
table(rg$occupation_partner)
rg = rg %>% mutate(oc_pt_bm = as.numeric(occupation_partner=="Business Manager"),
                   oc_pt_hw = as.numeric(occupation_partner=="Housewife"),
                   oc_pt_mw = as.numeric(occupation_partner=="Manual Worker"),
                   oc_pt_pro = as.numeric(occupation_partner=="Professional"),
                   oc_pt_rtd = as.numeric(occupation_partner=="Retired"),
                   oc_pt_sec = as.numeric(occupation_partner=="Secretarial/Admin"),
                   oc_pt_oth = as.numeric(occupation_partner %in% c("Other", "Unknown"))) %>%
  select(-occupation_partner)

#6 home_status
table(rg$home_status)
rg = rg %>% mutate(hm_own = as.numeric(home_status=="Own Home"),
                   hm_rn_cn = as.numeric(home_status=="Rent from Council/HA"),
                   hm_rn_pvt = as.numeric(home_status=="Rent Privately"),
                   hm_oth = as.numeric(home_status=="Unclassified")) %>% 
  select(-home_status)

#7 Family Income. We can convert it to numeric but the format is too complex. We convert it to dummies for intervals.
table(rg$family_income)
rg = rg %>% mutate(inc_8k_4k = as.numeric(family_income=="< 8,000, >= 4,000"),
                   inc_10k_8k = as.numeric(family_income=="<10,000, >= 8,000"),
                   inc_12.5k_10k = as.numeric(family_income=="<12,500, >=10,000"),
                   inc_15k_12.5k = as.numeric(family_income=="<15,000, >=12,500"),
                   inc_17.5k_15k = as.numeric(family_income=="<17,500, >=15,000"),
                   inc_20k_17.5k = as.numeric(family_income=="<20,000, >=17,500"),
                   inc_22.5k_20k = as.numeric(family_income=="<22,500, >=20,000"),
                   inc_25k_22.5k = as.numeric(family_income=="<25,000, >=22,500"),
                   inc_27.5k_25k = as.numeric(family_income=="<27,500, >=25,000"),
                   inc_35k = as.numeric(family_income==">=35,000")) %>% 
  select(-family_income)

#8 self_employed
table(rg$self_employed)
rg = rg %>% mutate(self_emp = as.numeric(self_employed=="Yes")) %>%
  select(-self_employed)

#9 self_employed_partner
table(rg$self_employed_partner)
rg = rg %>% mutate(self_emp_pt = as.numeric(self_employed_partner=="Yes")) %>%
  select(-self_employed_partner)

#10 TVArea
table(rg$TVarea)
rg = rg %>% mutate(tv_ang = as.numeric(TVarea=="Anglia"),
                   tv_carl = as.numeric(TVarea=="Carlton"),
                   tv_cent = as.numeric(TVarea=="Central"),
                   tv_yrk = as.numeric(TVarea=="Yorkshire"),
                   tv_gran = as.numeric(TVarea=="Granada"),
                   tv_htv = as.numeric(TVarea=="HTV"),
                   tv_mer = as.numeric(TVarea=="Meridian"),
                   tv_sct = as.numeric(TVarea=="Scottish TV"),
                   tv_tt = as.numeric(TVarea=="Tyne Tees")) %>% 
  select(-TVarea)

#11 post_area. Takes too much unique values. Will skip creating dummy. Will just drop them.
table(rg$post_area)
rg = rg %>% select(-post_area)

#12 post_code. Takes too much unique values. Will skip creating dummy.Will just drop them.
table(rg$post_code)
rg = rg %>% select(-post_code)

#13 gender
table(rg$gender)
rg = rg %>% mutate(is_male = as.numeric(gender=="Male")) %>% select(-gender)

#14 region
table(rg$region)
rg = rg %>% mutate(reg_eang = as.numeric(region=="East Anglia"),
                   reg_emid = as.numeric(region=="East Midlands"),
                   reg_nor = as.numeric(region=="North"),
                   reg_norW = as.numeric(region=="North West"),
                   reg_scot = as.numeric(region=="Scotland"),
                   reg_se = as.numeric(region=="South East"),
                   reg_sw = as.numeric(region=="South West"),
                   reg_wls = as.numeric(region=="Wales"),
                   reg_wml = as.numeric(region=="West Midlands")) %>% 
  select(-region)

glimpse(rg)

rg$avg_credit_txn <- rg$Average.Credit.Card.Transaction
rg$Average.Credit.Card.Transaction <- NULL

rg$inv_mfund <- rg$Investment.in.Mutual.Fund
rg$Investment.in.Mutual.Fund <- NULL

rg$inv_bond <- rg$Investment.Tax.Saving.Bond
rg$Investment.Tax.Saving.Bond <- NULL

rg$inv_comm <- rg$Investment.in.Commudity
rg$Investment.in.Commudity <- NULL

rg$inv_derv <- rg$Investment.in.Derivative
rg$Investment.in.Derivative <- NULL

rg$inv_equi <- rg$Investment.in.Equity
rg$Investment.in.Equity <- NULL

rg$on_purscs <- rg$Online.Purchase.Amount
rg$Online.Purchase.Amount <- NULL

#We need to convert our response variable to 1 or 0. It has values 1 or 2. It needs to have 1 or 0.
rg$Revenue.Grid = as.numeric(rg$Revenue.Grid==1)


#We can break the data into test and train data.
set.seed(2)
s = sample(1:nrow(rg), 0.8*nrow(rg))
rg_train = rg[s,]
rg_test = rg[-s,]

#A final check for NAs.
sum(is.na(rg_test))
sum(is.na(rg_test))