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

## Convert date and time
datentime <- strptime(paste(powerdata$V1, powerdata$V2, sep = " "), format = "%d/%m/%Y %H:%M:%S")

## Plot the graph
plot(datentime, powerdata$V3, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Copy the plot to a png file
dev.copy(png,file = "plot2.png", width = 480, height = 480)

## Close the png device
dev.off()
