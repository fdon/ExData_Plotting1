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


#plot1
png(file="plot1.png",width=480,height=480)
hist(shpc$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()