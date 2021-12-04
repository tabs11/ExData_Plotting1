##get column names
headers<-read.table("household_power_consumption.txt",nrows=1,sep=';')
# read the data from 2007-02-01 and 2007-02-02
date_range<-grep('^[1,2]/2/2007', x=readLines("household_power_consumption.txt"),value = TRUE)
epc <- read.table(text = date_range,sep=';',na.string=c("?"),col.names = as.character(headers))

##convert the proper fields to date and time
epc$Date<-as.Date(strptime(epc$Date,'%d/%m/%Y'))
epc$dateTime <- as.POSIXct(paste(epc$Date, epc$Time))

##PLOT3
png("plot3.png", width=480, height=480)
par(mar = c(6, 6, 4, 4))
plot(epc$Sub_metering_1~epc$dateTime,type='l',ylab="Energy sub metering",xlab="")
lines(epc$Sub_metering_2~epc$dateTime,type='l',col='red')
lines(epc$Sub_metering_3~epc$dateTime,type='l',col='blue')
legend("topright",legend=c('Sub_meetering_1','Sub_meetering_2','Sub_meetering_3'),lwd=1,col=c('black','red','blue'))
dev.off()