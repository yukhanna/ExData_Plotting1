# Uses data from the UC Irvine Machine Learning Repository.
# The data is: "Individual household electric power consumption Data Set"
# This measures electric power consumption in one household with a
# one-minute sampling rate over a period of almost 4 years.
# Different electrical quantities and some sub-metering values are available.

#downloads the file and unzips the data
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, "energydata.zip")
unzip("energydata.zip", exdir = "energydata")

fileName <- "energydata/household_power_consumption.txt"

# reads in the data, noting that NA values are marked as '?'
data <- read.table(fileName, sep=";", na.strings="?", header=TRUE,
                   stringsAsFactors=FALSE, comment.char="")

# Converts the Date column to a "Date" format to make subsetting easier
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Subsets data from two specific dates, Feb. 1 and 2, 2007
dataSub <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

##Combines date and time columns into one Date column, in POSIXct format
dataSub$Date <- with(dataSub, as.POSIXct(paste(Date, Time)))

#deletes old Time column
dataSub <- dataSub[,-2]

# Plots the three sub metering variables against the date.
# Also includes a legend.

png("plot3.png")

with(dataSub, plot(Date, Sub_metering_1, type="l",
                   ylab="Energy sub metering", xlab=""))
with(dataSub, lines(Date, Sub_metering_2, col="red"))
with(dataSub, lines(Date, Sub_metering_3, col="blue"))

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3"), lty=c(1,1),
       col = c("black", "red", "blue"),
       cex=1)

dev.off()