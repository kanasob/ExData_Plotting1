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

##Plot 4 Multi Base Plot: 
## top-left Plot: household global minute-averaged active power 
## top-right Plot: minute-averaged voltage
## bottom-left Plot: household global minute-averaged active power by usage
## bottom-right Plot: household global minute-averaged reactive power
## Then saving plot (plot4.png)

png("plot4.png", height = 480, width = 480)
par(mfrow = c(2,2))
with(datafeb,{
  plot(Global_active_power~datetime, type = "l", xlab = "",
       ylab = "Global Active Power")
  
  plot(Voltage~datetime, type = "l", xlab = "datetime",
       ylab = "Voltage")
  
  plot(Sub_metering_1~datetime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~datetime, col="red")
  lines(Sub_metering_3~datetime, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lty = 1, lwd = 2, cex = 0.8, pch = 1, pt.cex = 1, bty = "n",
         col = c("black", "red", "blue"))
  
  plot(Global_reactive_power~datetime, type = "l", xlab = "datetime",
       ylab = "Global_reactive_power")
  
})


dev.off

