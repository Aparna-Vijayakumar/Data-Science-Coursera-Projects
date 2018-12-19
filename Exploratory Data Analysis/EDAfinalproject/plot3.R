## Of the four types of sources indicated by the 
## type(point, nonpoint, onroad, nonroad) variable, which of these four 
## sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)
## Read PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")

## Take only Baltimore City, Maryland's data
NEI <- subset(NEI, NEI$fips == 24510)

## Summing the PM2.5 for all source types for each year
sumtypes <- aggregate(NEI$Emissions, list(NEI$year,NEI$type), FUN = sum, na.rm = T)

## Rename columns
sumtypes <- setNames(sumtypes, c("Year","Type","PM2.5"))
png("plot3.png") 

## Plot
#qplot(Year, PM2.5, data = sumtypes, color = Type, main = "PM2.5 emissions(tons) of each type in Baltimore City")
g <-ggplot(sumtypes, aes(x = factor(Year), y = PM2.5, fill = Type))
g + geom_bar(stat = "identity") + facet_grid(.~Type) + xlab("Year") + 
  ylab("PM2.5 emissions (tons)") + 
  ggtitle("PM2.5 emissions of each type in Baltimore City") 

## Close the png device
dev.off()
