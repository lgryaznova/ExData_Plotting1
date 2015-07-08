
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

## create png file and put the requested plot in it
png(file = "plot2.png", width = 480, height = 480)
plot(data$Date_Time, data$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()


