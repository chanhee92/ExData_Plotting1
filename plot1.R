### Plot histogram of Global Active power from 01/07/2007-02/07/2007

dat <- read.table("household_power_consumption.txt", sep = ";", 
                  header = TRUE, colClasses = "character")

## Create a column of POSIXlt values (Date/Time) to be read later.
date.time <- paste(dat$Date, dat$Time)
date.time <- strptime(date.time, "%d/%m/%Y %H:%M:%S") 
dat$'Date/Time'<- date.time 

# Select data from 2007/02/01 to /02
needed <- as.Date(dat$`Date/Time`) == as.Date("2007-02-01") |
            as.Date(dat$`Date/Time`) == as.Date("2007-02-02")
data <- dat[needed,]

# Variable to be plotted must a numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

#Plot histograph with red bars into plot1.png
png("plot1.png", width = 480, height = 480)

hist(data$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()