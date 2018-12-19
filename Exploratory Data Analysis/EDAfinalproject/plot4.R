## Across the United States, how have emissions from coal 
## combustion-related sources changed from 1999–2008?

library(ggplot2)
## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge
merged_data <- merge(NEI, SCC, by = "SCC")

## Find coal sources
coal <- grepl("coal", merged_data$Short.Name, ignore.case = TRUE)
datasubset <- merged_data[coal,]

## Summing the PM2.5 for coal related sources for each year
datasubset <- aggregate(datasubset$Emissions, list(datasubset$year), FUN = sum, na.rm = T)

## Rename columns
datasubset <- setNames(datasubset, c("Year","PM2.5"))
png("plot4.png") 

## Plot
g <-ggplot(datasubset, aes(x = factor(Year), y = PM2.5/1000, fill = Year))
g + geom_bar(stat = "identity") + xlab("Year") + 
  ylab("PM2.5 emissions (kilotons)") + 
  ggtitle("PM2.5 emissions of coal combustion-related sources") 

## Close the png device
dev.off()
