# Author: Petteri Moilanen
# Date: 10.11.2018 (3rd November 2018)
# A short data wrangling script for the IODS course RStudio Exercise 3.
#
# I'm in the habit of setting the working directory excplicitly. If you need to do the same, uncomment the next line.
setwd("~/GitHub/IODS-project/data")
# Read data
mat=read.table("student-mat.csv",sep=";",header=TRUE)
por=read.table("student-por.csv",sep=";",header=TRUE)
dim(mat)
str(mat)
dim(por)
str(por)
# Join rows
library(dplyr)
join_by = c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob",
            "Fjob","reason","nursery","internet")
both=inner_join(mat,por,by=join_by)
dim(both)
str(both)

# 
# create a new data frame with only the joined columns
alc <- select(both, one_of(join_by))
# columns that were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  two_columns <- select(both, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

#
alc$alc_use <- (alc$Dalc+alc$Walc)/2 
alc$high_use <- (alc$alc_use>2)
glimpse(alc)
write.csv2(alc,"~/GitHub/IODS-project/data/alcohol.csv",row.names=FALSE)

