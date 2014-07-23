#Question 1

data <- read.csv("./data/getdata-data-ss06hid.csv")

acres <- data$ACR==3
sales <- data$AGS==6
query <- (data$ACR==3 & data$AGS==6)
data$agricultureLogical <- ifelse(query, TRUE, FALSE)
which(data$agricultureLogical)


#Question 2


#Question 3
# Read and tidy gdp data
library(plyr)
gdp <- read.csv("./data/getdata-data-GDP.csv", skip=4, stringsAsFactors=F, na.strings='NULL')
gdpTidy <- gdp[which(ifelse(gdp$X.1 %in% 1:190, TRUE, FALSE)),]
gdpTidy <- transform(gdpTidy, X.1 = as.numeric(X.1))
gdpTidy <- rename(gdpTidy, c("X"="CountryCode", "X.1"="GdpRanking", "X.4"="GdpAmount"))
colnames(gdpTidy)

ed <- read.csv("./data/getdata-data-EDSTATS_Country.csv")

#Match the data based on the country shortcode. How many of the IDs match?
inGdp <- ed$CountryCode %in% gdpTidy$CountryCode
length(which(inGdp))

#Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame? 
gdpTidy[order(gdpTidy$GdpRanking, decreasing=TRUE),][13,]


# Question 4
#What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

merged <- merge(x=ed, y=gdpTidy, by.x="CountryCode", by.y="CountryCode", all.y=TRUE)

highOecd <- merged[merged$Income.Group == "High income: OECD", c(1:3, 32)]
highNonOecd <- merged[merged$Income.Group == "High income: nonOECD", c(1:3, 32)]
mean(highOecd$GdpRanking, na.rm=TRUE)
mean(highNonOecd$GdpRanking, na.rm=TRUE)


# Question 5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
# How many countries are Lower middle income but among the 38 nations with highest GDP?
library(Hmisc)
merged$rankingGroup = cut2(merged$GdpRanking, g=5)

tab <- table(merged$Income.Group, merged$rankingGroup)
tab[5,1]
