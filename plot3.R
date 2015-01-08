data <- read.csv2("household_power_consumption.txt", nrows = 70000)

# get POSIXct by combining Date and Time variables
data <- transform(data, Time = as.POSIXlt(paste(Date, Time), format = "%d/%m/%Y %H:%M"))

# get only required days
data <- subset(data, (data$Time >= as.POSIXlt("1/2/2007", format = "%d/%m/%Y")) & (data$Time < as.POSIXlt("3/2/2007", format = "%d/%m/%Y")))

# convert factor levels of sub metering variables to numeric values
data <- transform(data, Sub_metering_1 = as.numeric(levels(Sub_metering_1))[Sub_metering_1])
data <- transform(data, Sub_metering_2 = as.numeric(levels(Sub_metering_2))[Sub_metering_2])
data <- transform(data, Sub_metering_3 = as.numeric(levels(Sub_metering_3))[Sub_metering_3])

# changing the locale (for English day names)
Sys.setlocale("LC_TIME", "English")

# draw on png graphics device
png(filename = "plot3.png")
with(data, plot(Time, Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering"))
with(data, lines(Time, Sub_metering_1))
with(data, lines(Time, Sub_metering_2, col="red"))
with(data, lines(Time, Sub_metering_3, col="blue"))
legend("topright", pch="", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()