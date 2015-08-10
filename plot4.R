### Create a panel of four plots containing:
### Global Active Power over Time
### Voltage over time
### Energy submetering (1-3) over time
### Global_reactive_power over time

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
data[ ,3:9] <- apply(data[ ,3:9], 2, as.numeric)

# Plot
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

plot(data$'Date/Time', data$Global_active_power, type = "l",
     ylab = "Global Active Power", xlab = "")

plot(data$'Date/Time', data$Voltage, type = "l",
     ylab = "Voltage", xlab = "datetime")

plot(data$'Date/Time', data[,7], type = "l", col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(data$'Date/Time', data[,8], type = "l", col = "red")
lines(data$'Date/Time', data[,9], type = "l", col = "blue")
legend("topright", lty = c(1, 1), col = c("black", "red", "blue"),
       legend = names(data[7:9]), box.lwd = NA, bg = NA)

plot(data$'Date/Time', data$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
