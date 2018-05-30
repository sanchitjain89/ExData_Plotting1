#passed as an argument to colClasses in fread
myClasses <- c(rep('character', 2), rep('numeric', 7))


#Formatting - date and time
hpc <- fread("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?", "NA"), colClasses = myClasses)
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpcSubset <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02"]
hpcSubset$DateTime <- paste(hpcSubset$Date, hpcSubset$Time, sep = " ")
hpcSubset$DateTime <- as.POSIXct(hpcSubset$DateTime, format = "%Y-%m-%d %H:%M:%S")

#Creating png file
png(filename = "Plot3.png", width = 480, height = 480)

#Writing plot to png file
plot(hpcSubset$DateTime, hpcSubset$Sub_metering_1, type = 'n', xlab = "", ylab = "Energy sub metering")

lines(hpcSubset$DateTime, hpcSubset$Sub_metering_1, lwd = 2, col = "black")
lines(hpcSubset$DateTime, hpcSubset$Sub_metering_2, lwd = 2, col = "red")
lines(hpcSubset$DateTime, hpcSubset$Sub_metering_3, lwd = 2, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), cex = 1, lty = 1)

#Close
dev.off()
