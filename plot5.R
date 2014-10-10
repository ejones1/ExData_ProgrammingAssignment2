# Sets wd saved location of data
setwd("C:/Users/joneseri/Coursera/ExploratoryDataAnalysis/exdata_data_NEI_data")

# Reads-in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Loads ggplot2 package
library(ggplot2)

# Subsets Baltimore City emissions data
NEIbalt <- subset(NEI, NEI$fips == 24510)

# Subsets Batlimore City motor vehicle emissions data
SCC_vehs <- subset(SCC, grepl("Vehicles", EI.Sector)) 
NEIbalt_vehs <- subset(NEIbalt, NEIbalt$SCC %in% SCC_vehs$SCC)

# Adds up the total vehicle emissions for each year
balt_allVehs <- tapply(NEIbalt_vehs$Emissions, NEIbalt_vehs$year, sum)

# Converts balt_allVehs matrix to a dataframe & renames cols and rows
balt_allVehs <- as.data.frame(balt_allVehs)
colnames(balt_allVehs) <- c("Emissions")
Year <- rownames(balt_allVehs)

# Plots emissions from motor vehicle sources in Baltimore City from
# 1999-2008
plot5 <- ggplot(balt_allVehs, aes(Year, Emissions, group = 1))
plot5 <- plot5 + geom_line() + labs(y = "Baltimore Vehicle Emissions")

ggsave(filename = "plot5.png", plot5)
