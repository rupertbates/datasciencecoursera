pollution <- read.csv("data/avgpm25.csv", colClasses = c("numeric", "character", "factor", "numeric", "numeric"))
summary(pollution$pm25)

boxplot(pollution$pm25, col = "blue")

hist(pollution$pm25, col = "green") 
rug(pollution$pm25)

hist(pollution$pm25, col = "green", breaks = 100) 
rug(pollution$pm25)

# Overlaying features
boxplot(pollution$pm25, col = "blue") 
abline(h = 12)

hist(pollution$pm25, col = "green")
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)

# Bar plot
barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")

# Summaries - 2 dimensions

boxplot(pm25 ~ region, data = pollution, col = "red")

par(mfrow = c(2, 1), mar = c(4, 4, 2, 1)) 
hist(subset(pollution, region == "east")$pm25, col = "green") 
hist(subset(pollution, region == "west")$pm25, col = "green")
par(mfrow=c(1,1))

# Scatter plots
with(pollution, plot(latitude, pm25)) 
abline(h=12,lwd=2,lty=2)

# With colour
with(pollution, plot(latitude, pm25, col = region)) 
abline(h=12,lwd=2,lty=2)

# Multiple scatter plots
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West")) 
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))


if(!require(ggplot2))
  install.packages("ggplot2")
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)
head(mpg)
qplot(trans, hwy, data = mpg)
unique(mpg$year)