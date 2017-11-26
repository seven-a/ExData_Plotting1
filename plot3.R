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

png(file = "plot3.png")
with(hpc, plot(Datetime, Sub_metering_1, type = "n", 
               xlab = "",
               ylab = "Energy sub metering"))
lines(hpc$Datetime, hpc$Sub_metering_1)
lines(hpc$Datetime, hpc$Sub_metering_2, col = "red")
lines(hpc$Datetime, hpc$Sub_metering_3, col = "blue")
legend("topright", lwd = c(1, 1, 1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
dev.off()
