# Sets wd saved location of data
setwd("C:/Users/joneseri/Coursera/ExploratoryDataAnalysis/exdata_data_NEI_data")

# Reads-in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Loads ggplot2 package
library(ggplot2)

# Subsets SCC and NEI data to include only vehicles
SCC_vehs <- subset(SCC, grepl("Vehicles", EI.Sector)) 
NEI_vehs <- subset(NEI, NEI$SCC %in% SCC_vehs$SCC)

# Subsets Batlimore City and LA County motor vehicle emissions data
BaltLA_vehs <- subset(NEI_vehs, fips %in% c("24510", "06037"))

# Creates a dataframe that lists the total emissions for Baltimore and
# LA County vehicle emissions per year
all_vehs <- aggregate(BaltLA_vehs$Emissions, 
                      by = list(BaltLA_vehs$year, BaltLA_vehs$fips),
                      FUN = "sum")
names(all_vehs) <- c("Year", "location", "Emissions")

# Renames fips numbers (location col) to Baltimore/LA County
all_vehs$Location <- "Baltimore"
all_vehs$Location[all_vehs$location == "06037"] <- "LA County"

# Plots a comparisson of motor vehicle emissions in Baltimore City and
# LA County between 1999-2008
plot6 <- ggplot(all_vehs, aes(Year, Emissions, col = Location))
plot6 <- plot6 + geom_line() + labs(y = "Total Vehicle Emissions")

ggsave(filename="plot6.png", plot6)