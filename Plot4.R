#passed as an argument to colClasses in fread
myClasses <- c(rep('character', 2), rep('numeric', 7))

#Gathering the data in required format
hpc <- fread("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?", "NA"), colClasses = myClasses)
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpcSubset <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02"]
hpcSubset$DateTime <- paste(hpcSubset$Date, hpcSubset$Time, sep = " ")
hpcSubset$DateTime <- as.POSIXct(hpcSubset$DateTime, format = "%Y-%m-%d %H:%M:%S")

#Creating png file
png(filename = "Plot4.png", width = 480, height = 480)

#Setting screen parameters
par(mfrow = c(2, 2))

#First subplot

plot(hpcSubset$DateTime, hpcSubset$Global_active_power, type = 'n', xlab = "", ylab = "Global Active power")
lines(hpcSubset$DateTime, hpcSubset$Global_active_power, lwd = 2, col = "black")

# Second subplot(upper right)

plot(hpcSubset$DateTime, hpcSubset$Voltage, type = 'n', xlab = "datetime", ylab = "Voltage")
lines(hpcSubset$DateTime, hpcSubset$Voltage, lwd = 2, col = "black")

# Third subplot - Same as plot 3
plot(hpcSubset$DateTime, hpcSubset$Sub_metering_1, type = 'n', xlab = "", ylab = "Energy sub metering")

lines(hpcSubset$DateTime, hpcSubset$Sub_metering_1, lwd = 2, col = "black")
lines(hpcSubset$DateTime, hpcSubset$Sub_metering_2, lwd = 2, col = "red")
lines(hpcSubset$DateTime, hpcSubset$Sub_metering_3, lwd = 2, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, cex = 1, bty = "n")

# Fourth
plot(hpcSubset$DateTime, hpcSubset$Global_reactive_power, type = 'n', xlab = "datetime", ylab = "Global_reactive_power")
lines(hpcSubset$DateTime, hpcSubset$Global_reactive_power, lwd = 2, col = "black")


#Close
dev.off()
