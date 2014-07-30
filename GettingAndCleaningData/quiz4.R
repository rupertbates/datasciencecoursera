# Question 1
dat <- read.csv("./data/getdata-data-ss06hid.csv")
names(dat)
splits <- sapply(names(dat), strsplit, split="wgtp")
splits[123]

# Question 2
library(plyr)
gdp <- read.csv("./data/getdata-data-GDP.csv", skip=4, stringsAsFactors=F, na.strings='NULL')
gdpTidy <- gdp[which(ifelse(gdp$X.1 %in% 1:190, TRUE, FALSE)),]
gdpTidy <- transform(gdpTidy, X.1 = as.numeric(X.1))
gdpTidy <- rename(gdpTidy, c("X"="CountryCode", "X.1"="GdpRanking", "X.4"="GdpAmount", "X.3"="CountryName"))
colnames(gdpTidy)

gdpTidy$GdpAmount <- as.numeric(gsub(",","", gdpTidy$GdpAmount))

mean(gdpTidy$GdpAmount)

# Question 3
countryNames <- gdpTidy$CountryName
uniteds <- grep("^United", countryNames)
length(uniteds)

# Question 4
ed <- read.csv("./data/getdata-data-EDSTATS_Country.csv")
merged <- merge(x=ed, y=gdpTidy, by.x="CountryCode", by.y="CountryCode", all.y=TRUE)
inJune <- merged[grep("Fiscal year end: June", merged$Special.Notes),c(1:2, 10)]
nrow(inJune)

# Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
dates <- as.Date(sampleTimes, "%Y-%m-%d")
twentyTwelve <- dates[grep("2012", format(dates, "%Y"))]
length(twentyTwelve)
length(grep("Monday", weekdays(twentyTwelve)))
