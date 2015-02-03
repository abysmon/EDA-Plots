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

# Plot 3
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(power$DateTime, power$Sub_metering_1, type = 'l', xlab = "", 
     ylab = "Energy sub metering")
lines(power$DateTime, power$Sub_metering_2, col = "red")
lines(power$DateTime, power$Sub_metering_3, col = "blue", )
legend("topright", colnames(power)[7:9],col = c("black","red","blue"), 
       cex=1.0, lty=1)
dev.off()