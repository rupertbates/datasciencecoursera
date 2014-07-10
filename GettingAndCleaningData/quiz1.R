setwd("~/Projects/datasciencecoursera//GettingAndCleaningData")

#Questions 1 & 2
dataFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
dictFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
if(!file.exists("data")){
  dir.create("data")
}
download.file(dataFile, destfile="./data/american-community-survey.csv", method="curl")
download.file(dictFile, destfile="./data/american-community-survey-dictionary.pdf", method="curl")

list.files("./data")

data <- read.csv("./data/american-community-survey.csv")
hasValues <- data[!is.na(datatable$VAL),]
nrow(hasValues[hasValues$VAL == 24,])


#Question 3
library(xlsx)
dataFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(dataFile, destfile="./data/natural-gas-program.xlsx", method="curl")
list.files("./data")

dat <- read.xlsx("./data/natural-gas-program.xlsx", sheetIndex=1, rowIndex=18:23, colIndex=7:15)
answer <-  sum(dat$Zip*dat$Ext,na.rm=T)

#Question 4
library(XML)
dataFile <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
#download.file(dataFile, destfile="./data/restaurants.xml", method="curl")
doc <- xmlTreeParse(dataFile, useInternalNodes=TRUE)
rootNode <- xmlRoot(doc)
# xmlName(rootNode)
# names(rootNode)
# rootNode[[1]][[1]]
xpathSApply(rootNode, "//row[zipcode=21231]", xmlValue)

#Question 5
library(data.table)
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
dataFile <- "./data/community-survey-2006.csv"
download.file(dataUrl, destfile=dataFile, method="curl")
list.files("./data")


