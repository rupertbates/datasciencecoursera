# Question 1

NEI <- readRDS("summarySCC_PM25.rds")
NEI$YearDate <- strptime(NEI$year, format="%Y")

emissionsByYear <- aggregate(Emissions ~ year, data=NEI, sum)

png(filename="plot1.png", width=500, height=500)
plot(emissionsByYear, type="o", main="Total PM2.5 emissions in the United States", xaxt="n")
axis(side=1, at=c(1999,2002,2005,2008), tick=FALSE,  labels=c("1999", "2002", "2005", "2008"))
dev.off()

# Question 2

NEI <- readRDS("summarySCC_PM25.rds")
NEI$YearDate <- strptime(NEI$year, format="%Y")

baltimore <- NEI[NEI$fips=="24510", ]
baltimoreEmissionsByYear <- aggregate(Emissions ~ year, data=baltimore, sum)

png(filename="plot2.png", width=500, height=500)
plot(baltimoreEmissionsByYear, type="o", main="Total PM2.5 emissions - Baltimore", xaxt="n")
axis(side=1, at=c(1999,2002,2005,2008), tick=FALSE,  labels=c("1999", "2002", "2005", "2008"))
dev.off()