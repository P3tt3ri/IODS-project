# IODS Ex 6 - Data wrangling script

# Changing data to long form turns the repeated measures of the subject each to its 
# own data row. The operation is analogous to normalizing a relational database table: we turn a repeating column into 
# individual rows in the table.

setwd("~/GitHub/IODS-project/data")

library(dplyr)
library(tidyr)

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
                    sep  =" ", header = T)

names(BPRS)
str(BPRS)
dim(BPRS)
summary(BPRS)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
glimpse(BPRSL)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", 
                   sep  ="\t", header = T)

names(RATS)
str(RATS)
dim(RATS)
summary(RATS)

RATS$ID = factor(RATS$ID)
RATS$Group = factor(RATS$Group)
RATSL <-  RATS %>% gather(key = days, value = wght, -ID, -Group)
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(days,3,4)))
glimpse(RATSL)


write.csv2(BPRSL,"~/GitHub/IODS-project/data/bprsl.csv", row.names = FALSE)
write.csv2(RATSL,"~/GitHub/IODS-project/data/ratsl.csv", row.names = FALSE)
