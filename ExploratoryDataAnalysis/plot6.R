if(!require(ggplot2))
  install.packages("ggplot2")
library(ggplot2)

if(!require(reshape2))
  install.packages("reshape2")
library(reshape2)

#Read in data
NEI <- readRDS("summarySCC_PM25.rds")

#Read in classification codes
SCC <- readRDS("Source_Classification_Code.rds")
#Get the codes pertaining to motor vehicles
trafficCodes <- SCC[grep("Mobile - .*Vehicles", SCC$EI.Sector), c("SCC", "EI.Sector")]

getDataSet <- function(fips, title){
  #Get data for the given city
  ds <- NEI[NEI$fips==fips, ]
  
  #Filter to motor vehicle data only
  dsTraffic <- ds[ds$SCC %in% trafficCodes$SCC, ]
  
  #Add some columns to help with plotting
  dsTraffic$YearFactor <- as.factor(dsTraffic$year)
  dsTraffic$City <- title 
  
  #Melt & reshape the dataset
  dsMelt <- melt(dsTraffic, measure.vars=c("Emissions"))
  dsAll <- dcast(dsMelt, YearFactor + City ~ variable, sum)
  #Work out the year on year change
  dsAll <- transform(dsAll, Change = Emissions - Emissions[1])
}

#Get data for each of the cities
baltimore <- getDataSet("24510", "Baltimore") 
la <- getDataSet("06037", "Los Angeles County")

dsBoth <- rbind(baltimore, la)

#plot
ggplot(dsBoth, aes(YearFactor, Change)) +  
  geom_point() +
  geom_line(aes(group=City, color=City)) +
  labs(x="Year", title="Changes in vehicle emissions in Baltimore & Los Angeles County")

ggsave(filename="plot6.png", dpi=72)
