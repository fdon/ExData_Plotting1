library(lubridate)
#lubridate is used in the hms function. Facilitates manipulation of date and time strings.

class <- c("character", "character", "numeric", "numeric","numeric", "numeric","numeric", "numeric","numeric")
#this makes it simple to assign the right data type to each variable

hpc <- read.table("../data/household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",colClasses = class)
#hpc contains all data

#Convert the string in the date variable to a Date format
hpc$Date<-as.Date(hpc$Date,format="%d/%m/%Y")

#shpc contains a subset of this data for the two first days of Feb 2007
shpc<-subset(hpc,hpc$Date=="2007-02-01"|hpc$Date=="2007-02-02")

#convert time string such as "02:25:48" to a Time, using the hms function
shpc$Time<-hms(shpc$Time)

#merge the Date and Time columns into a new variable called "datetime"
shpc$datetime <-shpc$Date+shpc$Time

#plot4
png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2))
with(shpc,plot(datetime,Global_active_power,type = "l",ylab="Gobal Active Power", xlab=""))
with(shpc,plot(datetime,Voltage,type = "l"))
with(shpc,plot(datetime,Sub_metering_1,type = "l",ylab="Energy sub metering", xlab=""))
with(shpc,lines(datetime,Sub_metering_2, col="red"))
with(shpc,lines(datetime,Sub_metering_3, col="blue"))
legend("top", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(2,2,2),bty="n",cex=0.7)
with(shpc,plot(datetime,Global_reactive_power,type = "l"))
dev.off()
