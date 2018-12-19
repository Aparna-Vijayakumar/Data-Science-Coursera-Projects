## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, 
## California (fips == "06037"). Which city has seen greater changes over time
## in motor vehicle emissions?

library(ggplot2)
## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge
merged_data <- merge(NEI, SCC, by = "SCC")

## Take only Baltimore City's and Los Angeles' data with on road type 
datasubset <- merged_data[(merged_data$fips=="24510"|merged_data$fips=="06037") & merged_data$type=="ON-ROAD", ]

## Summing the PM2.5 for coal related sources for each year
datasubset <- aggregate(datasubset$Emissions, list(datasubset$year, datasubset$fips), sum, na.rm = T)

## Rename columns
datasubset <- setNames(datasubset, c("Year","County","PM2.5"))

png("plot6.png") 

## Plot
g <-ggplot(datasubset, aes(x = factor(Year), y = PM2.5, fill = Year))
g + geom_bar(stat = "identity") + xlab("Year") + facet_grid(. ~ County)
  ylab("PM2.5 emissions (tons)") + 
  ggtitle("PM2.5 emissions of motor vehicle sources in Baltimore City and Los Angeles County") 

## Close the png device
dev.off()


