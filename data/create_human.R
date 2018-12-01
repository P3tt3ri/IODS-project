# A short data wrangling script for the IODS course RStudio Exercise 4.
# Petteri Moilanen
# Human develompment data set
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

# Description of 'human' dataset variables. 
# Original data from: http://hdr.undp.org/en/content/human-development-index-hdi
# Retrieved, modified and analyzed by Tuomo Nieminen 2017

# The data combines several indicators from most countries in the world

# "Country" = Country name

# Health and knowledge

# "GNI" = Gross National Income per capita
# "Life.Exp" = Life expectancy at birth
# "Edu.Exp" = Expected years of schooling 
# "Mat.Mor" = Maternal mortality ratio
# "Ado.Birth" = Adolescent birth rate

# Empowerment

# "Parli.F" = Percetange of female representatives in parliament
# "Edu2.F" = Proportion of females with at least secondary education
# "Edu2.M" = Proportion of males with at least secondary education
# "Labo.F" = Proportion of females in the labour force
# "Labo.M" " Proportion of males in the labour force

# "Edu2.FM" = Edu2.F / Edu2.M
# "Labo.FM" = Labo2.F / Labo2.M

setwd("~/GitHub/IODS-project/data")

human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", 
                    sep  =",", header = T)

names(human)
str(human)
dim(human)
summary(human)
library(stringr)
human$GNI = as.numeric(str_replace(human$GNI, pattern=",", replace =""))
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
library(dplyr)
human <- select(human, one_of(keep))
# Only rows with no missing values
human <- filter(human, complete.cases(human))
# Exclude last 7 rows (region data)
human <- human[1:155,]
rownames(human) <- human$Country
human <- human[-1]
write.csv2(human,"~/GitHub/IODS-project/data/human.csv",row.names=TRUE)

