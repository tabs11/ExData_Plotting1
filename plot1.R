##get column names
headers<-read.table("household_power_consumption.txt",nrows=1,sep=';')
# read the data from 2007-02-01 and 2007-02-02
date_range<-grep('^[1,2]/2/2007', x=readLines("household_power_consumption.txt"),value = TRUE)
epc <- read.table(text = date_range,sep=';',na.string=c("?"),col.names = as.character(headers))

##PLOT1

hist(epc$Global_active_power,col="red",xlab = "Global Active Power (kilowatts)",main="Global Active Power")

#save to png
dev.copy(png,"plot1.png")
dev.off()