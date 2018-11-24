# A short data wrangling script for the IODS course RStudio Exercise 4.
#
# I'm in the habit of setting the working directory excplicitly. If you need to do the same, uncomment the next line.
setwd("~/GitHub/IODS-project/data")
# Read data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
#
str(hd)
summary(hd)
str(gii)
summary(gii)

library(dplyr)
hd2 <- hd %>% rename(hdiRank=HDI.Rank,country=Country,index=Human.Development.Index..HDI.,
                     lifeExp=Life.Expectancy.at.Birth,expYersOfEdu=Expected.Years.of.Education,
                     meanYearsOfEdu=Mean.Years.of.Education, gni=Gross.National.Income..GNI..per.Capita,
                     gniRankMinusHdiRank = GNI.per.Capita.Rank.Minus.HDI.Rank)
gii2 <- gii %>% rename(giiRank=GII.Rank,country=Country,inequalityIndex=Gender.Inequality.Index..GII.,
                       matMort=Maternal.Mortality.Ratio,adolBirth=Adolescent.Birth.Rate,
                       parlamentRatio=Percent.Representation.in.Parliament,
                       secondEduFem=Population.with.Secondary.Education..Female.,
                       secondEduMale=Population.with.Secondary.Education..Male.,
                       labourPartFem=Labour.Force.Participation.Rate..Female.,
                       labourPartMale=Labour.Force.Participation.Rate..Male.)

gii2$eduRatio = gii2$secondEduFem/gii2$secondEduMale
gii2$labourRatio = gii2$labourPartFem/gii2$labourPartMale
human=inner_join(hd2,gii2,by="country")

write.csv2(human,"~/GitHub/IODS-project/data/human.csv",row.names=FALSE)

