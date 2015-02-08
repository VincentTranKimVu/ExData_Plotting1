#Description: Measurements of electric power consumption in one household 
#with a one-minute sampling rate over a period of almost 4 years.
#Different electrical quantities and some sub-metering values are available

#Loading the data. Read data from file
fileName <- "./household_power_consumption.txt"
dataFile <- read.table(file=fileName, sep=";", header=TRUE)

#Get data ranges
dataFile$Date <- as.Date (dataFile$Date, format = "%d/%m/%Y")
processingRange <- dataFile[(dataFile$Date == "2007-02-01") | (dataFile$Date == "2007-02-02"),]

#Getting data fields
processingRange <- transform(processingRange, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
processingRange$Global_active_power <- as.numeric(as.character(processingRange$Global_active_power))

#Drawing image
plot(processingRange$timestamp, processingRange$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")
#Save to file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
