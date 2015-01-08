data <- read.csv2("household_power_consumption.txt", nrows = 70000)

# get POSIXct by combining Date and Time variables
data <- transform(data, Time = as.POSIXlt(paste(Date, Time), format = "%d/%m/%Y %H:%M"))

# get only required days
data <- subset(data, (data$Time >= as.POSIXlt("1/2/2007", format = "%d/%m/%Y")) & (data$Time < as.POSIXlt("3/2/2007", format = "%d/%m/%Y")))

# convert factor levels of required variables to numeric values
data <- transform(data, Global_active_power = as.numeric(levels(Global_active_power))[Global_active_power])
data <- transform(data, Sub_metering_1 = as.numeric(levels(Sub_metering_1))[Sub_metering_1])
data <- transform(data, Sub_metering_2 = as.numeric(levels(Sub_metering_2))[Sub_metering_2])
data <- transform(data, Sub_metering_3 = as.numeric(levels(Sub_metering_3))[Sub_metering_3])
data <- transform(data, Voltage = as.numeric(levels(Voltage))[Voltage])
data <- transform(data, Global_reactive_power = as.numeric(levels(Global_reactive_power))[Global_reactive_power])

# changing the locale (for English day names)
Sys.setlocale("LC_TIME", "English")

# draw on png graphics device
png(filename = "plot4.png")
par(mfrow = c(2,2))

with(data, {
     plot(Time, Global_active_power, type="n", xlab="", ylab = "Global Active Power")
     lines(Time, Global_active_power)
     
     plot(Time, Voltage, type="n", xlab="datetime", ylab = "Voltage")
     lines(Time, Voltage)
     
     plot(Time, Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering")
     lines(Time, Sub_metering_1)
     lines(Time, Sub_metering_2, col="red")
     lines(Time, Sub_metering_3, col="blue")
     legend("topright", bty = "n", pch="", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

     plot(Time, Global_reactive_power, type="n", xlab="datetime")
     lines(Time, Global_reactive_power)
     
     })


dev.off()