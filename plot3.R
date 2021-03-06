# read in the data of interest (i.e., from 2007-02-01 to 2007-02-02)
# assumes data is extracted from .zip file and saved directly to working directory
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                                 "Voltage", "Global_intensity", "Sub_metering_1", 
                                 "Sub_metering_2", "Sub_metering_3"), na.strings = "?",
                   colClasses = c(rep("character", 2), rep("numeric", 7)),
                   skip = 66637, nrows = 2880, comment.char = "")
# make a copy of the original to preserve it
working.data <- data
# convert dates and times to proper formating in working copy, and combine into
# one variable
working.data$date.time <- strptime(paste(working.data$Date, working.data$Time, sep=" "),
                                   format="%d/%m/%Y %H:%M:%S")
# add variable for the day of the week
working.data$day.week <- weekdays(working.data$date.time)
# plot the desired line graph
plot(working.data$date.time, working.data$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(working.data$date.time, working.data$Sub_metering_2, col = "red")
lines(working.data$date.time, working.data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = rep(1, 3), pt.cex = 1, cex = 0.6)
# copy the plot from the screen device to the file device
dev.copy(png, file = "plot3.png")
dev.off()