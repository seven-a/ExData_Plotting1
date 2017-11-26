### assume that data is downloaded and unziped to the working directory

# reading data

library(readr)  
library(dplyr)  


hpc_all <- read_csv2("household_power_consumption.txt", na = c("?", "NA"))
hpc <- filter(hpc_all, Date == "1/2/2007"|Date == "2/2/2007")
rm(hpc_all) # to save memory

library(lubridate)
hpc$Datetime <- dmy_hms(paste(hpc$Date, hpc$Time))
hpc$Global_active_power <- as.numeric(hpc$Global_active_power)
hpc$Global_reactive_power <- as.numeric(hpc$Global_reactive_power)
hpc$VoltageDiv <- hpc$Voltage/1000

  png(file = "plot4.png")
par(mfrow = c(2, 2))

#plot1    
with(hpc, plot(Datetime, Global_active_power, type = "n", 
               xlab = "",
               ylab = "Global active power (kilowatts)"))
lines(hpc$Datetime, hpc$Global_active_power)

#plot2
with(hpc, plot(Datetime, VoltageDiv, type = "n", 
               xlab = "datetime",
               ylab = "Voltage"))
lines(hpc$Datetime, hpc$VoltageDiv)

#plot3
with(hpc, plot(Datetime, Sub_metering_1, type = "n", 
               xlab = "",
               ylab = "Energy sub metering"))
lines(hpc$Datetime, hpc$Sub_metering_1)
lines(hpc$Datetime, hpc$Sub_metering_2, col = "red")
lines(hpc$Datetime, hpc$Sub_metering_3, col = "blue")
legend("topright", lwd = c(1, 1, 1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

#plot4
with(hpc, plot(Datetime, Global_reactive_power, type = "n"))
lines(hpc$Datetime, hpc$Global_reactive_power)

dev.off()
