if(!require(ggplot2))
  install.packages("ggplot2")
library(ggplot2)

if(!require(reshape2))
  install.packages("reshape2")
library(reshape2)

NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

coalCodes <- SCC[grep("Coal", SCC$EI.Sector), c("SCC", "EI.Sector")]

fromCoal <- NEI[NEI$SCC %in% coalCodes$SCC, ]

merged <- merge(coalCodes, fromCoal, by.x="SCC", by.y="SCC")
merged$YearFactor <- as.factor(merged$year)

df_melt <- melt(merged, measure.vars=c("Emissions"))
df_cast <- dcast(df_melt, YearFactor + EI.Sector ~ variable, sum)
df_all <- dcast(df_melt, YearFactor ~ variable, sum)
df_all$EI.Sector <- rep("All coal sources", times=length(unique(df_cast$YearFactor)))
df_plot <- rbind(df_cast, df_all)

ggplot(df_plot, aes(YearFactor, Emissions)) +  
  geom_point() +
  geom_line(aes(group=EI.Sector, color=EI.Sector)) +
  labs(x="Year", title="Total PM2.5 emissions from coal combustion in the United States")

ggsave(filename="plot4.png", dpi=72)
