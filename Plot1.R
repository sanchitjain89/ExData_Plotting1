#Plot 1

#passed as an argument to colClasses in fread
myClasses <- c(rep('character', 2), rep('numeric', 7))

#Reading the data
hpc <- fread("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?", "NA"), colClasses = myClasses)

#Formatting - date and time
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpcSubset <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02"]
hpcSubset$DateTime <- paste(hpcSubset$Date, hpcSubset$Time, sep = " ")
hpcSubset$DateTime <- as.POSIXct(hpcSubset$DateTime, format = "%Y-%m-%d %H:%M:%S")

#Creating png file
png(filename = "Plot1.png", width = 480, height = 480)

#Writing plot to the file
hist(hpcSubset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatts)", col = "red")

#Close
dev.off()
