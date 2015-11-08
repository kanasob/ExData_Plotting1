##Loading full dataset 
dt <- read.table("./data/household_power_consumption.txt", header = TRUE, sep=";",
                 na.strings = "?", nrows = 2075259, check.names = FALSE, 
                 stringsAsFactors = FALSE, comment.char = "")
alldata<-dt
alldata$Date <- as.Date(alldata$Date, format = "%d/%m/%Y")

##Subset the data (only use data between 2007-02-01 and 2007-02-02)
datafeb <- subset(alldata, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Add a new variable which captures every one-minute sampling rate per date
date_time <- paste (datafeb$Date, datafeb$Time)
datafeb[,"datetime"] <- as.POSIXct(date_time)

##Plot 3 Plot: household global minute-averaged active power 
##between 2007-02-01 and 2007-02-02 by usage
## - Sub_metering_1: Usage in the kitchen (a dishwasher, an oven and a microwave)
## - Sub_metering_2: Usage in the laundry room (a washing machine, an tumble dryer,
##   a refrigerator and a light)
## - Sub_metering_3: Usage of an electric water-heater and an air-conditioner
##Then save the plot

png("plot3.png", height = 480, width = 480)

with(datafeb, {
  plot(Sub_metering_1~datetime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~datetime, col="red")
  lines(Sub_metering_3~datetime, col = "blue")
})

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 2, cex = 0.8, pch = 1, pt.cex = 1, 
       col = c("black", "red", "blue"))

dev.off()

