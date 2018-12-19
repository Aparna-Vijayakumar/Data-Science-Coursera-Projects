## Have total emissions from PM2.5 decreased in the United States 
## from 1999 to 2008? Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008.

## Read PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")

## Summing the PM2.5 for all sources for each year
sumsources <- aggregate(NEI$Emissions, list(NEI$year,NEI$SCC), FUN = sum, na.rm = T)

## Rename columns
sumsources <- setNames(sumsources, c("Year","Source","PM2.5"))
png("plot1.png") 

## Plot
with(sumsources, plot(Year,PM2.5, xaxt = 'n', main = "Overall PM2.5 emmissions(tons) in USA"))
axis(side = 1, at= c("1999","2002","2005","2008"))

## Close the png device
dev.off()




