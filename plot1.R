##Loading full dataset 
dt <- read.table("./data/household_power_consumption.txt", header = TRUE, sep=";",
                 na.strings = "?", nrows = 2075259, check.names = FALSE, 
                 stringsAsFactors = FALSE, comment.char = "")
alldata<-dt
alldata$Date <- as.Date(alldata$Date, format = "%d/%m/%Y")

##Subset the data (only use data from the dates 2007-02-01 and 2007-02-02)
datafeb <- subset(alldata, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

##Plot 1 Histogram

hist(datafeb$Global_active_power, col = "red", main = "Global Active Power",
     xlab= "Global Active Power (kilowatts)")

## Saving plot (plot1.png)
dev.copy(png,file="plot1.png", height = 480, width = 480)
dev.off()