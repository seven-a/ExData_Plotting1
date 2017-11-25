### assume that data is downloaded and unziped to the working directory

# reading data

library(readr)  
library(dplyr)  


hpc_all <- read_csv2("household_power_consumption.txt", na = c("?", "NA"))
hpc <- filter(hpc_all, Date == "1/2/2007"|Date == "2/2/2007")
rm(hpc_all) # to save memory

library(lubridate)
hpc$Date <- dmy(hpc$Date)
hpc$Global_active_power <- as.numeric(hpc$Global_active_power)

png(file = "plot1.png")
hist(hpc$Global_active_power, col = "red", 
     xlab = "Global active power (kilowatts)", 
     main = "Global active power")
dev.off()
