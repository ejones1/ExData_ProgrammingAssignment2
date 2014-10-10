# Sets wd saved location of data
setwd("C:/Users/joneseri/Coursera/ExploratoryDataAnalysis/exdata_data_NEI_data")

# Reads-in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Loads ggplot package
library("ggplot2")

# Subsets data from NEI and SCC datasets to include only emissions
# from coal combustion-related sources
SCC_coal <- subset(SCC, grepl("Combustion", SCC.Level.One) 
                   & grepl("Coal", SCC.Level.Three))
NEI_coal <- subset(NEI, NEI$SCC %in% SCC_coal$SCC)

# Adds up the total coal combustion-realted emissions for each year
UScoalALL <- tapply(NEI_coal$Emissions, NEI_coal$year, sum)

# Converts UScoalALL matrix to a dataframe & renames cols and rows
UScoalALL <- as.data.frame(UScoalALL)
colnames(UScoalALL) <- c("Emissions")
Year <- rownames(UScoalALL)

# Plots US coal combustion-related data from 1999-2008
plot4 <- ggplot(UScoalALL, aes(Year, Emissions, group = 1))
plot4 <- plot4 + geom_line() + labs(y = "U.S. Coal Combustion-Related Emissions")

ggsave(filename = "plot4.png", plot = plot4)