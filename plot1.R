## plot1.R
##
## Exploratory Data Analysis, Project 1 : Recreate plot1
##
## data file: household_power_consumption.txt
## (from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)
## assume data file is in the working directory
##
## Only interested in timeframe 20070201 through 20070202
## 20070201 00:00:00 is on line 66638 (skip=66637)
## 20070202 23:59:00 is on line 69517
## 2880 rows in total (1440 minutes per day = 2880 observations across two days)

## set column names for the data set
col.names <- c("Date", 
               "Time", 
               "Global_active_power", 
               "Global_reactive_power", 
               "Voltage", 
               "Global_intensity", 
               "Sub_metering_1", 
               "Sub_metering_2", 
               "Sub_metering_3")

## set explicit column classes
col.classes <- c("character",
                 "character",
                 "numeric",
                 "numeric",
                 "numeric",
                 "numeric",
                 "numeric",
                 "numeric",
                 "numeric")

## read in the data (note: only rows corresponding to 2007-02-01 through 2007-02-02)
## in this data set, "?" = "NA"
data <- read.table("./household_power_consumption.txt", 
                  skip=66637, 
                  nrows=2880, 
                  sep=";", 
                  col.names=col.names,
                  colClasses = col.classes,
                  na.strings = "?")

## combine Date and Time to a single POSIXct vector; append a new column to the dataframe
datetime <- as.POSIXct(strptime(paste(data[,1], data[,2], sep=" "),
                                format = "%d/%m/%Y %H:%M:%S"))
data$DateTime <- datetime

## data are now ready for plotting

## PLOT1:
## open the PNG device
png("plot1.png", width=480, height=480)

## make the plot
graphics::hist(data$Global_active_power, 
               main="Global Active Power",
               xlab="Global Active Power (kilowatts)", 
               ylab="Frequency",
               col="red")

## close PNG file
dev.off()
