# Author: Petteri Moilanen
# Date: 03.11.2018 (3rd November 2018)
# A short data wrangling script for the IODS course RStudio Exercise 2.
#
# I'm in the habit of setting the working directory excplicitly. If you need to do the same, uncomment the next line.
# setwd("~/GitHub/IODS-project/data")

# Step 2
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(lrn14)
# 183 row (observations), 60 columns (variables).
str(lrn14)
# Age, gender and age of the subject plus a sum variable of attitude towards statistics and a bunch of variables to
# describe the said attitude.

# Step 3
library(dplyr)
#
lrn14$attitude <- lrn14$Attitude / 10
#
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surf_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
stra_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
surf_columns <- select(lrn14, one_of(surf_questions))
lrn14$surf <- rowMeans(surf_columns)
stra_columns <- select(lrn14, one_of(stra_questions))
lrn14$stra <- rowMeans(stra_columns)
#
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"
learning2014 <- filter(learning2014, points > 0)

# Step 4
setwd("~/GitHub/IODS-project")
write.csv2(learning2014,"~/GitHub/IODS-project/data/learning2014.csv",row.names=FALSE)
learning14_redux <- read.csv2("~/GitHub/IODS-project/data/learning2014.csv", header=TRUE)
str(learning14_redux)
head(learning14_redux)
