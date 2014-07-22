#Question 1

data <- read.csv("./data/getdata-data-ss06hid.csv")

acres <- data$ACR==3
sales <- data$AGS==6
query <- (data$ACR==3 & data$AGS==6)
data$agricultureLogical <- ifelse(query, TRUE, FALSE)
which(data$agricultureLogical)


#Question 2


#Question 3

gdp <- read.csv("./data/getdata-data-GDP.csv", skip=4 )
ed <- read.csv("./data/getdata-data-EDSTATS_Country.csv")
inGdp <- ed$CountryCode %in% gdp$X