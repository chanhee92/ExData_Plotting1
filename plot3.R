### Plot Submetering 1-3 over time

# Read data
dat <- read.table("household_power_consumption.txt", sep = ";",
                  header = TRUE, colClasses = "character")

# Create column Date/Time containing POSIXlt values to be read later
date.time <- paste(dat$Date, dat$Time)
date.time <- strptime(date.time, "%d/%m/%Y %H:%M:%S")
dat$'Date/Time' <- date.time

# Select data from 2007/02/01 to 02/02
needed <- as.Date(dat$`Date/Time`) == as.Date("2007-02-01") |
            as.Date(dat$`Date/Time`) == as.Date("2007-02-02")
data <- dat[needed, ]

# Variables to be plotted must be numeric
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Plot
png("plot3.png", width = 480, height = 480)

plot(data$'Date/Time', data[,7], type = "l", col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(data$'Date/Time', data[,8], type = "l", col = "red")
lines(data$'Date/Time', data[,9], type = "l", col = "blue")


legend("topright", lty = c(1, 1), col = c("black", "red", "blue"),
       legend = names(data[7:9]))


dev.off()