data <- read.csv("household_power_consumption 2.txt", header=T, sep = ';',  na.strings = '?', colClasses = c("character", "character", rep(NA,7)), as.is = T)

#combine date and time into POSIX object
new_date <- strptime(paste(data[[1]], data[[2]]), "%d/%m/%Y %H:%M:%S", tz ="")

#remove second column
data[[2]] <- NULL

#replace with the new date-time vector
data[[1]] <- new_date

#find data from 2007-02-01 and 2007-02-02
new_data <- data[data[[1]] >= "2007-02-01 00:00:00" & data[[1]] < "2007-02-03 00:00:00",]

png('plot4.png')
par(mfrow = c(2,2))

plot(new_data$Date, new_data$Global_active_power, ylab = "Global Active Power", xlab ="",type ='l' )
plot(new_data$Date, new_data$Voltage, ylab = "Voltage", xlab ="datetime",type ='l' )

yrange <- range(new_data[6:8], na.rm=T)

plot(new_data[[1]], new_data$Sub_metering_1, ylim = yrange, xlab = '',ylab = 'Energy sub metering', type ='l')
par(new=T)
plot(new_data[[1]],new_data$Sub_metering_2, axes = F, ylim = yrange,xlab = '',ylab ='', type ='l', col = 'red')
par(new=T)
plot(new_data[[1]],new_data$Sub_metering_3, axes = F,ylim = yrange,xlab = '',ylab ='', type ='l', col ='blue')
par(new=F)

legend("topright", legend = colnames(new_data)[6:8], lty= c(1,1,1), col=c("black","red","blue"))

plot(new_data$Date, new_data$Global_reactive_power, ylab = "Global Reactive Power", xlab = "datetime",type ='l')
dev.off()