# Sets wd saved location of data
setwd("C:/Users/joneseri/Coursera/ExploratoryDataAnalysis/exdata_data_NEI_data")

# Reads-in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculates the sum of all emissions per year & assigns years to 
# variable name
TotalEmissions <- rowsum(NEI$Emissions, NEI$year)
years <- rownames(TotalEmissions)

# Creates plot of total emissions from all sources for each of the 
# years 1999, 2002, 2005, and 2008
png(filename = "plot1.png")

plot(years, TotalEmissions, 
     xlab = "Year", 
     ylab = "Total Emissions",
     type = "o")

dev.off()
