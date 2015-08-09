#read data from file, separated by semicolon; skip header; read first two columns as character vector, the rest as numeric 
data <- read.csv("household_power_consumption 2.txt", header=T, sep = ';',  na.strings = '?', colClasses = c("character", "character", rep(NA,7)), as.is = T)

#combine date and time into POSIX object
new_date <- strptime(paste(data[[1]], data[[2]]), "%d/%m/%Y %H:%M:%S", tz ="")

#remove second column
data[[2]] <- NULL

#replace with the new date-time vector
data[[1]] <- new_date

#find data from 2007-02-01 and 2007-02-02
new_data <- data[data[[1]] >= "2007-02-01 00:00:00" & data[[1]] < "2007-02-03 00:00:00",]

yrange <- range(new_data[6:8], na.rm=T)

png('plot3.png')

plot(new_data[[1]], new_data$Sub_metering_1, ylim = yrange, xlab = '',ylab = 'Energy sub metering', type ='l')
par(new=T)
plot(new_data[[1]],new_data$Sub_metering_2, axes = F, ylim = yrange,xlab = '',ylab ='', type ='l', col = 'red')

par(new=T)
plot(new_data[[1]],new_data$Sub_metering_3, axes = F,ylim = yrange,xlab = '',ylab ='', type ='l', col ='blue')
par(new=F)

legend("topright", legend = colnames(new_data)[6:8], lty= c(1,1,1), col=c("black","red","blue"))

dev.off()