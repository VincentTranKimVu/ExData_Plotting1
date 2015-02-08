#Loading the data. Read data from file
fileName <- "./household_power_consumption.txt"
dataFile <- read.table(file=fileName, sep=";", header=TRUE)

#Get data ranges
dataFile$Date <- as.Date (dataFile$Date, format = "%d/%m/%Y")
processingRange <- dataFile[(dataFile$Date == "2007-02-01") | (dataFile$Date == "2007-02-02"),]

#Getting data fields
processingRange <- transform(processingRange, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
processingRange$Global_active_power <- as.numeric(as.character(processingRange$Global_active_power))
processingRange$Global_reactive_power <- as.numeric(as.character(processingRange$Global_reactive_power))
processingRange$Voltage <- as.numeric(as.character(processingRange$Voltage))
processingRange$Sub_metering_1 <- as.numeric(as.character(processingRange$Sub_metering_1))
processingRange$Sub_metering_2 <- as.numeric(as.character(processingRange$Sub_metering_2))
processingRange$Sub_metering_3 <- as.numeric(as.character(processingRange$Sub_metering_3))

#Separate windows to 4 pieces
par(mfrow=c(2,2))

#Plot 1
plot(processingRange$timestamp, processingRange$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")

#Plot 2
plot(processingRange$timestamp,processingRange$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Plot 3
plot(processingRange$timestamp,processingRange$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(processingRange$timestamp,processingRange$Sub_metering_2,col="red")
lines(processingRange$timestamp,processingRange$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

#Plot 4
plot(processingRange$timestamp,processingRange$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
#Save to file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
