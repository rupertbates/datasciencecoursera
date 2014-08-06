# Question 1

NEI <- readRDS("summarySCC_PM25.rds")
NEI$YearDate <- strptime(NEI$year, format="%Y")

emmissionsByYear <- aggregate(Emissions ~ year, data=NEI, sum)

plot(emmissionsByYear, type="o", main="Total PM2.5 emissions in the United States", xaxt="n")
axis(side=1, at=c(1999,2002,2005,2008), tick=FALSE,  labels=c("1999", "2002", "2005", "2008"))


