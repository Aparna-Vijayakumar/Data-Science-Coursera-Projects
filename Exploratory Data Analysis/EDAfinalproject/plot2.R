## Have total emissions from PM2.5 decreased in the Baltimore City,
## Maryland (fips == "24510") from 1999 to 2008? Use the base plotting
## system to make a plot answering this question.

## Read PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")

## Take only Baltimore City, Maryland's data
NEI <- subset(NEI, NEI$fips == 24510)

## Summing the PM2.5 for all sources for each year
sumsources <- aggregate(NEI$Emissions, list(NEI$year,NEI$SCC), FUN = sum, na.rm = T)

## Rename columns
sumsources <- setNames(sumsources, c("Year","Source","PM2.5"))
png("plot2.png") 

## Plot
with(sumsources, plot(Year,PM2.5, xaxt = 'n',main = "PM2.5 emmissions(tons) in Baltimore City"))
axis(side = 1, at= c("1999","2002","2005","2008"))

## Close the png device
dev.off()
