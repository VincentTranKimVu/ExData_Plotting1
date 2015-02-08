#Loading the data. Read data from file
fileName <- "./household_power_consumption.txt"
dataFile <- read.table(file=fileName, sep=";", header=TRUE)

#Get data ranges
dataFile$Date <- as.Date (dataFile$Date, format = "%d/%m/%Y")
processingRange <- dataFile[(dataFile$Date == "2007-02-01") | (dataFile$Date == "2007-02-02"),]

#Getting data fields
processingRange <- transform(processingRange, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
processingRange$Sub_metering_1 <- as.numeric(as.character(processingRange$Sub_metering_1))
processingRange$Sub_metering_2 <- as.numeric(as.character(processingRange$Sub_metering_2))
processingRange$Sub_metering_3 <- as.numeric(as.character(processingRange$Sub_metering_3))

#Drawing image
plot(processingRange$timestamp,processingRange$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(processingRange$timestamp,processingRange$Sub_metering_2,col="red")
lines(processingRange$timestamp,processingRange$Sub_metering_3,col="blue")

legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
#Save to file
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
