# Checking the working directory and setting it ... 
getwd()
setwd("e:/GCD_data/")

# Now i read in the data
alldata <- "e:/GCD_data/exdata-data-household_power_consumption/household_power_consumption.txt"
allpower <- read.table(alldata, header=T, sep=";")

#Then i changed the format of the column date
allpower$Date <- as.Date(allpower$Date, format="%d/%m/%Y")

#Subset to the period of interest
powerdf <- allpower[(allpower$Date=="2007-02-01") | (allpower$Date=="2007-02-02"),]

#Convering text to numerical form  
powerdf$Global_active_power <- as.numeric(as.character(powerdf$Global_active_power))
powerdf$Global_reactive_power <- as.numeric(as.character(powerdf$Global_reactive_power))
powerdf$Voltage <- as.numeric(as.character(powerdf$Voltage))

powerdf <- transform(powerdf, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
powerdf$Sub_metering_1 <- as.numeric(as.character(powerdf$Sub_metering_1))
powerdf$Sub_metering_2 <- as.numeric(as.character(powerdf$Sub_metering_2))
powerdf$Sub_metering_3 <- as.numeric(as.character(powerdf$Sub_metering_3))


plot1 <- function() {
  hist(powerdf$Global_active_power, main = paste("Global Active Power"), col="orange", xlab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  cat("Plot1.png has been saved in", getwd())
}
plot1()
