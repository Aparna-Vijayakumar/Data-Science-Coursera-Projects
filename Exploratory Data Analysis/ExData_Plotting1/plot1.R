## Download the data from UCi repository into a temporary file
temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = temp)

## Read data only from the specified dates
powerdata <- read.table(unz(temp,"household_power_consumption.txt"), sep = ";", skip = 66637, nrows = 2880)
unlink(temp)

## Replace ? with NAs
gsub("?","NA",powerdata$V3)
powerdata <- subset(powerdata, !is.na(powerdata$V3))

## Plot the histogram on the screen 
hist(powerdata$V3, breaks = 11, col = "red", freq = T, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

## Copy the plot to a png file
dev.copy(png,file = "plot1.png", width = 480, height = 480)

## Close the png device
dev.off()
