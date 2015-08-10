### Plot a graph of Global Active Plot over Time

dat <- read.table("household_power_consumption.txt", sep = ";",
                  header = TRUE, colClasses = "character")

# Create a column of POSIXlt values (Date/Time) to be read later.
date.time <- paste(dat$Date, dat$Time)
date.time <- strptime(date.time, "%d/%m/%Y %H:%M:%S")
dat$'Date/Time' <- date.time

# Select data from 07==2007/02/01 - /02
needed <- as.Date(dat$`Date/Time`) == as.Date("2007-02-01") |
            as.Date(dat$`Date/Time`) == as.Date("2007-02-02")
data <- dat[needed, ]

# Variable to be plotted must be numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# Plot graph
png("plot2.png", width = 480, height = 480)
plot(data$'Date/Time', data$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()