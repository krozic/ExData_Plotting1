if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data/house_data.zip")){download.file(fileUrl, "./data/house_data.zip", method = "curl")}
if(!file.exists("./data/household_power_consumption.txt")){unzip("./data/house_data.zip", exdir = "./data/")}

houseData <- read.table("./data/household_power_consumption.txt", 
                        header = TRUE, 
                        sep = ";", 
                        na.strings = "?")

#Modify date and time to POSITx
houseData$Date <- as.Date(houseData$Date, format = "%d/%m/%Y")
#houseData$Time <- strptime(houseData$Time, format = "%H:%M:%S")
houseData$datetime <- strptime(paste(houseData$Date, houseData$Time), 
                               format = "%Y-%m-%d %H:%M:%S")

#Subset days 2007-02-01 and -02
subhouseData <- subset(houseData, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

#Open file device
png(filename = "plot3.png",
    width = 480, 
    height = 480, 
    units = "px")

#Plot3
par(mfrow = c(1, 1))
with(subhouseData, 
     plot(datetime, 
          Sub_metering_1, 
          type = "l", 
          xlab = "", 
          ylab = "Energy sub metering"))
lines(subhouseData$datetime, 
      subhouseData$Sub_metering_2, 
      col = "red")
lines(subhouseData$datetime, 
      subhouseData$Sub_metering_3, 
      col = "blue")
legend("topright", 
       lty = c(1, 1, 1), 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()