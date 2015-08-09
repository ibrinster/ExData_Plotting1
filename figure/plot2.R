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

plot(new_data[[1]], new_data$Global_active_power, xlab = '',ylab = 'Global Active Power (kilowatts)', main = "Global Active Power", type ='l')

#copy to png file
dev.copy(png, 'plot2.png')
dev.off()