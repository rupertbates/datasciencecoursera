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

#Get Baltimore data
baltimore <- NEI[NEI$fips=="24510", ]

#Motor vehicle data in baltimore
fromTraffic <- baltimore[baltimore$SCC %in% trafficCodes$SCC, ]

#Merge the codes with the main data set
merged <- merge(trafficCodes, fromTraffic, by.x="SCC", by.y="SCC")
merged$YearFactor <- as.factor(merged$year)

#Melt & reshape the dataset
df_melt <- melt(merged, measure.vars=c("Emissions"))
df_cast <- dcast(df_melt, YearFactor + EI.Sector ~ variable, sum)
df_all <- dcast(df_melt, YearFactor ~ variable, sum)
df_all$EI.Sector <- rep("All motor vehicle sources", times=length(unique(df_cast$YearFactor)))

#Plot
df_plot <- rbind(df_cast, df_all)

ggplot(df_plot, aes(YearFactor, Emissions)) +  
  geom_point() +
  geom_line(aes(group=EI.Sector, color=EI.Sector)) +
  labs(x="Year", title="Total PM2.5 emissions from motor vehicle sources in Baltimore")

ggsave(filename="plot5.png", dpi=72)
