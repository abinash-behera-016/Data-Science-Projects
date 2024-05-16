#Here is a custom funtion provided by our instructor to create dummies for different unique values present in a character column with occurring frequency more than a specified value.

CreateDummies = function(data,var,freq_cutoff){
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

#You define a list of the column names you want dummies to be created for.
for_dummy_vars = c('your column name1', 'your column name2', 'your column name3', 'your column name4')

#Then we can combine the custom fucntion and a for loop to create dummies for those columns. 
for(var in for_dummy_vars){
  youdataset = CreateDummies(youdataset,var, yourfrequencycutoff)}

#You should keep the yourfrequencycutoff around 2% of the total number of rows just to make sure you don't make dummies for all the classes present in a column. 
#In this way you don't end up with a massive number of dummies for rare classes and over complicate things.
#fastdummies package is works great too but it doesn't support a frequency cut off feature.