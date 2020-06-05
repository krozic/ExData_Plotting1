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
houseData$datetime <- strptime(paste(houseData$Date, houseData$Time), 
                               format = "%Y-%m-%d %H:%M:%S")

#Subset days 2007-02-01 and -02
subhouseData <- subset(houseData, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

#Open file device
png(filename = "plot1.png",
    width = 480, 
    height = 480, 
    units = "px")

#Plot1
par(mfrow = c(1, 1))
hist(subhouseData$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()