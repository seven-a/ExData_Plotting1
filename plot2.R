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

png(file = "plot2.png")
with(hpc, plot(Datetime, Global_active_power, type = "n", 
               xlab = "",
               ylab = "Global active power (kilowatts)"))
lines(hpc$Datetime, hpc$Global_active_power)
dev.off()
