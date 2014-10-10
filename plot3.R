# Sets wd saved location of data
setwd("C:/Users/joneseri/Coursera/ExploratoryDataAnalysis/exdata_data_NEI_data")

# Reads-in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Loads ggplot package
library("ggplot2")

# Subsets Baltimore City data
balt <- subset(NEI, NEI$fips == 24510)
baltEmissionsType <- aggregate(balt$Emissions, 
                               by = list(balt$year, balt$type),
                               FUN = "sum")
names(baltEmissionsType) <- c("Year", "Type", "Emissions")
  
# Plots the different types of emissions in Baltimore City
# using the ggplot2 package
plot <- qplot(data = baltEmissionsType, 
              x = Year, 
              y = Emissions,
              col = Type,
              geom = "line")

ggsave(filename = "plot3.png", plot = plot)