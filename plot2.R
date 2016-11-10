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

# plots the Global_Active_Power variable against the date

png("plot2.png")
with(dataSub, plot(Date, Global_active_power, type="l",
                   ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()


