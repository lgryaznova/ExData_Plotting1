
## download and unzip file if necessary
if(!file.exists("household_power_consumption.txt")) {
    urlzip <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(urlzip, destfile = "consumption.zip", 
                  method = "internal", mode = "wb")
    unzip(zipfile = "consumption.zip")
    rm(urlzip)
}

## read the file
data <- read.table(file = "household_power_consumption.txt",
                   header = TRUE, sep = ";", na.strings = "?")

## subset two days
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

## merge date and time, convert into POSIX
Date_Time <- paste(data$Date, data$Time, sep = " ")
Date_Time <- strptime(Date_Time, format = "%d/%m/%Y %H:%M:%S")
data <- cbind(Date_Time, data)

## remove unnecessary columns and objects
data <- data[, -c(2:3)]
rm(Date_Time)

## create png file and put the requested plots in it
png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))
## plot 1
plot(data$Date_Time, data$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power")
## plot 2
plot(data$Date_Time, data$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")
## plot 3
plot(data$Date_Time, data$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
lines(data$Date_Time, data$Sub_metering_2, col = "red")
lines(data$Date_Time, data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## plot 4
plot(data$Date_Time, data$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()


