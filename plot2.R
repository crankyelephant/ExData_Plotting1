data <- read.csv2("household_power_consumption.txt", nrows = 70000)

# get POSIXct by combining Date and Time variables
data <- transform(data, Time = as.POSIXlt(paste(Date, Time), format = "%d/%m/%Y %H:%M"))

# get only required days
data <- subset(data, (data$Time >= as.POSIXlt("1/2/2007", format = "%d/%m/%Y")) & (data$Time < as.POSIXlt("3/2/2007", format = "%d/%m/%Y")))

# convert factor levels of Global_active_power to numeric values
data <- transform(data, Global_active_power = as.numeric(levels(Global_active_power))[Global_active_power])

# changing the locale (for English day names)
Sys.setlocale("LC_TIME", "English")

# draw on png graphics device
png(filename = "plot2.png")
with(data, plot(Time, Global_active_power, type="n", xlab="", ylab = "Global Active Power (kilowatts)"))
with(data, lines(Time, Global_active_power))
dev.off()
