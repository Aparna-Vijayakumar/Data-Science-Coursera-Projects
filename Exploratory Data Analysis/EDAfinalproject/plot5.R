##How have emissions from motor vehicle sources changed from 
## 1999–2008 in Baltimore City?

library(ggplot2)
## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge
merged_data <- merge(NEI, SCC, by = "SCC")

## Take only Baltimore City, Maryland's data
merged_data <- subset(merged_data, merged_data$fips == 24510)

## Find motor vehicle sources
datasubset <- subset(merged_data, merged_data$type == "ON-ROAD")

## Summing the PM2.5 for coal related sources for each year
datasubset <- aggregate(datasubset$Emissions, list(datasubset$year), FUN = sum, na.rm = T)

## Rename columns
datasubset <- setNames(datasubset, c("Year","PM2.5"))
png("plot5.png") 

## Plot
g <-ggplot(datasubset, aes(x = factor(Year), y = PM2.5, fill = Year))
g + geom_bar(stat = "identity") + xlab("Year") + 
  ylab("PM2.5 emissions (tons)") + 
  ggtitle("PM2.5 emissions of motor vehicle sources in Baltimore City") 

## Close the png device
dev.off()


