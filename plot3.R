## plot3.R
##
## Exploratory Data Analysis, Project 1 : Recreate plot3
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

## PLOT3:
## open the PNG device
png("plot3.png", width=480, height=480)

## make the plot
with(data, {
  plot(DateTime, 
       Sub_metering_1, 
       type="l", 
       xlab="", 
       ylab="Energy sub metering",
       col="black")
  
  lines(DateTime, 
       Sub_metering_2, 
       type="l", 
       col="red")
  
  lines(DateTime, 
       Sub_metering_3, 
       type="l", 
       col="blue")
  
  legend(x="topright",
         lty=1,
         col=c("black", "red", "blue"),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

## close PNG file
dev.off()
