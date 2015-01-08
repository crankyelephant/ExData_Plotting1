data <- read.csv2("household_power_consumption.txt", nrows = 70000)

# get POSIXct by combining Date and Time variables
data <- transform(data, Time = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M"))

# get only required days
data <- subset(data, (data$Time >= as.POSIXct("1/2/2007", format = "%d/%m/%Y")) & (data$Time < as.POSIXct("3/2/2007", format = "%d/%m/%Y")))

# convert factor levels of Global_active_power to numeric values
data <- transform(data, Global_active_power = as.numeric(levels(Global_active_power))[Global_active_power])

# draw on png graphics device
png(filename = "plot1.png")
hist(data$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()