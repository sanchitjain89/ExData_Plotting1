#passed as an argument to colClasses in fread
myClasses <- c(rep('character', 2), rep('numeric', 7))

#Gathering the data in required format
hpc <- fread("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?", "NA"), colClasses = myClasses)

hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpcSubset <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02"]
hpcSubset$DateTime <- paste(hpcSubset$Date, hpcSubset$Time, sep = " ")
hpcSubset$DateTime <- as.POSIXct(hpcSubset$DateTime, format = "%Y-%m-%d %H:%M:%S")

#Creating png file
png(filename = "Plot2.png", width = 480, height = 480)

#Writing plot to it
with(hpcSubset, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power(kilowatts)", xlab = ''))

#Close
dev.off()