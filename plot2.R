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

## Plot 2 Plot: household global minute-averaged active power between 2007-02-01 and 2007-02-02
plot(datafeb$datetime, datafeb$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")

## ## Saving plot (plot2.png)
dev.copy(png,"plot2.png", height = 480, width = 480)
dev.off()