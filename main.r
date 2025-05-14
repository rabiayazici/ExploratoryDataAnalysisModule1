# Load necessary libraries
library(data.table)

# Read the data
data <- fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

# Convert Date and Time into proper Date/Time classes
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Subset the data for the dates 2007-02-01 and 2007-02-02
subset_data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]
# Plot 1: Global Active Power Histogram
png("plot1.png", width=480, height=480)

hist(subset_data$Global_active_power, 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency")

dev.off()
# Plot 2: Voltage over time
png("plot2.png", width=480, height=480)

plot(subset_data$Time, subset_data$Voltage, 
     type="l", 
     col="black", 
     main="Voltage over Time", 
     xlab="Time", 
     ylab="Voltage (volt)")

dev.off()
# Plot 3: Energy Sub-metering
png("plot3.png", width=480, height=480)

plot(subset_data$Time, subset_data$Sub_metering_1, 
     type="l", 
     col="black", 
     xlab="Time", 
     ylab="Energy Sub-metering", 
     main="Energy Sub-metering over Time")

lines(subset_data$Time, subset_data$Sub_metering_2, col="red")
lines(subset_data$Time, subset_data$Sub_metering_3, col="blue")

legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty=1)

dev.off()
# Plot 4: Global Active Power, Global Reactive Power, and Global Intensity
png("plot4.png", width=480, height=480)

par(mfrow=c(2, 2))

# Plot Global Active Power
plot(subset_data$Time, subset_data$Global_active_power, 
     type="l", 
     col="black", 
     xlab="Time", 
     ylab="Global Active Power (kilowatts)", 
     main="Global Active Power")

# Plot Global Reactive Power
plot(subset_data$Time, subset_data$Global_reactive_power, 
     type="l", 
     col="blue", 
     xlab="Time", 
     ylab="Global Reactive Power (kilowatts)", 
     main="Global Reactive Power")

# Plot Voltage
plot(subset_data$Time, subset_data$Voltage, 
     type="l", 
     col="green", 
     xlab="Time", 
     ylab="Voltage (volt)", 
     main="Voltage")

# Plot Global Intensity
plot(subset_data$Time, subset_data$Global_intensity, 
     type="l", 
     col="purple", 
     xlab="Time", 
     ylab="Global Intensity (ampere)", 
     main="Global Intensity")

dev.off()
