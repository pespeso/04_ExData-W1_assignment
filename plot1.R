#library(data.table)

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "data/data.zip", method="curl")
unzip("data/data.zip", exdir ="data")

filePath = "data/household_power_consumption.txt"
df <- read.table(filePath, header = TRUE, sep=";", na.strings = "?")

df$Date <- as.Date(df$Date, "%d/%m/%Y")

df <- subset(df,Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

hist(df$Global_active_power,
     main="Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col="red")

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

