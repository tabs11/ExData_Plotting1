setwd("C:/Users/numartin/Desktop/Coursera/Data Science R/Exploratory data Analysis/Week1_Prog_assign/")
library(dplyr)
library(data.table)
if(!file.exists("exdata_data_household_power_consumption.zip")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl,destfile="exdata_data_household_power_consumption.zip",method="curl")
}
# Checking if folder exists and unzip the content
if (!file.exists("household_power_consumption.txt")) { 
        unzip('exdata_data_household_power_consumption.zip') 
}
##memory estimation
(2075259*9*8/(2^20))/1024
##reading file with fread

#headers<-read.table("household_power_consumption.txt",nrows=1,sep=';')
#system.time(
#start_date<-grep('^1/2/2007', x=readLines("household_power_consumption.txt"))[1]
#)
#system.time(
#end_date<-rev(grep('^2/2/2007', x=readLines("household_power_consumption.txt")))[1]
#)
#system.time(
#epc<-read.table("household_power_consumption.txt",skip = start_date-1,
#                 sep=';',na.string=c("?"),
#                 nrows=end_date-start_date+1)
#)
#colnames(epc)<-as.character(headers)
##or
epc <- fread("household_power_consumption.txt",na.string=c("?"))
epc=epc[grep("^1/2/2007|^2/2/2007",epc$Date),]

epc$Date<-as.Date(strptime(epc$Date,'%d/%m/%Y'))

epc$dateTime <- as.POSIXct(paste(epc$Date, epc$Time))
head(epc)
##PLOT1

hist(epc$Global_active_power,col="red",xlab = "Global Active Power (kilowatts)",main="Global Active Power")

##PLOT2
plot(epc$Global_active_power~epc$dateTime,type='l',xlab='',ylab='Global_active_power')

##plot3
plot(epc$Sub_metering_1~epc$dateTime,type='l',ylab="Energy sub metering",xlab="")
lines(epc$Sub_metering_2~epc$dateTime,type='l',col='red')
lines(epc$Sub_metering_3~epc$dateTime,type='l',col='blue')
legend("topright",legend=c('Sub_meetering_1','Sub_meetering_2','Sub_meetering_3'),lwd=c(1,1,1),col=c('black','red','blue'))

##plot4
dev.off()

par(mfrow=c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,2))
plot(epc$Global_active_power~epc$dateTime,type='l',xlab='',ylab='Global_active_power')
plot(epc$Voltage~epc$dateTime,type='l',xlab='datetime',ylab='Voltage')
plot(epc$Sub_metering_1~epc$dateTime,type='l',ylab="Energy sub metering",xlab="")
lines(epc$Sub_metering_2~epc$dateTime,type='l',col='red')
lines(epc$Sub_metering_3~epc$dateTime,type='l',col='blue')
legend("topright",legend=c('Sub_meetering_1','Sub_meetering_2','Sub_meetering_3'),lwd=c(1,1,1),col=c('black','red','blue'))
plot(epc$Global_reactive_power~epc$dateTime,type='l',xlab='datetime',ylab = "Global_reactive_power")

