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

## Set global parametrs for multiple plots
par(mfcol = c(2,2))

## Plot the graph
with(powerdata, {
  plot(datentime, V3, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  plot(datentime, V7, type = "l", xlab = "", ylab = "Energy sub metering")
    lines(datentime, V8, col = "red")
    lines(datentime, V9, col = "blue")
    legend("topright", lty = "solid", col = c("black","red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.3)
  plot(datentime, V5, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(datentime, V4, type = "l", xlab = "datetime", ylab = "global_reactive_power")
})

## Copy the plot to a png file
dev.copy(png,file = "plot4.png", width = 480, height = 480)

## Close the png device
dev.off()
