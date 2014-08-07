# Question 3

if(!require(ggplot2))
  install.packages("ggplot2")
library(ggplot2)

if(!require(reshape2))
  install.packages("reshape2")
library(reshape2)

NEI <- readRDS("summarySCC_PM25.rds")
NEI$YearFactor <- as.factor(NEI$year)

baltimore <- NEI[NEI$fips == "24510", c("Emissions", "type", "YearFactor")]

df_melt <- melt(baltimore, measure.vars=c("Emissions"))
df_cast <- dcast(df_melt, YearFactor + type ~ variable, sum)

ggplot(df_cast, aes(YearFactor, Emissions)) +  
  geom_point() +
  geom_line(aes(group=type, color=type)) +
  labs(x="Year", title="Total emissions by source for Baltimore")

ggsave(filename="plot3.png", dpi=72)
  
