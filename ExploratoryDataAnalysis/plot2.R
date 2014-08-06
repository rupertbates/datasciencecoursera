# Question 3

if(!require(ggplot2))
  install.packages("ggplot2")
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
NEI$YearFactor <- as.factor(NEI$year)
NEI$YearDate <- strptime(NEI$year, format="%Y")

baltimore <- NEI[NEI$fips == "24510", 4:6]

require(reshape2)
df_melt <- melt(baltimore, id=c(2,3))
df_cast <- dcast(df_melt, year + type ~ variable, sum)

ggplot(data=df_cast, aes(x=year, y=Emissions, group=Emissions, color=type)) + geom_point()
axis(side=1, at=c(1999,2002,2005,2008), tick=FALSE,  labels=c("1999", "2002", "2005", "2008"))
