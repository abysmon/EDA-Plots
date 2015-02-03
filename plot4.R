start.date = '1/2/2007' # d/m/y
end.date = '2/2/2007'

samp = read.table(file = 'household_power_consumption.txt', nrows = 1, 
                  sep = ";", header = T)

datecol = read.table(file = 'household_power_consumption.txt', header = T, 
                     colClasses = c("character",rep("NULL",ncol(samp)-1)),
                     sep = ";", na.strings = "?")

startidx = min(which(datecol$Date==start.date,arr.ind = T))
endidx = max(which(datecol$Date==end.date,arr.ind = T))
# rm(datecol)

power = read.table(file = 'household_power_consumption.txt', header = F, 
                   sep = ";", na.strings = "?", stringsAsFactors = F, 
                   skip = startidx, nrows = endidx-startidx+1)

colnames(power) = colnames(samp)
power$DateTime = strptime(paste(power$Date, power$Time), 
                          format = "%d/%m/%Y %H:%M:%S")

# Plot 4
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
plot(power$DateTime, power$Global_active_power, type = 'l', xlab = "", 
     cex.lab = 0.7, ylab = "Global Active Power (kilowatts)")
plot(power$DateTime, power$Voltage, type = 'l', xlab = "datetime", 
     ylab = "Voltage")
plot(power$DateTime, power$Sub_metering_1, type = 'l', xlab = "", 
     ylab = "Energy sub metering")
lines(power$DateTime, power$Sub_metering_2, col = "red")
lines(power$DateTime, power$Sub_metering_3, col = "blue")
legend("topright", colnames(power)[7:9],col = c("black","red","blue"), 
       cex=0.7, lty=1, bty = 'n')
plot(power$DateTime, power$Global_reactive_power, type = 'l', 
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
