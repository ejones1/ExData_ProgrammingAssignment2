# Sets wd saved location of data
setwd("C:/Users/joneseri/Coursera/ExploratoryDataAnalysis/exdata_data_NEI_data")

# Reads-in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsets Baltimore City emissions data
balt <- subset(NEI, NEI$fips == 24510)
BaltEmissions <- rowsum(balt$Emissions, balt$year)
years <- rownames(BaltEmissions)

# Creates plot of total emissions in Baltimore City from 1999-2008
png(filename = "plot2.png")

plot(years, BaltEmissions, 
     xlab = "Year",
     ylab = "Total Emissions in Baltimore, MD",
     type = "o")

dev.off()