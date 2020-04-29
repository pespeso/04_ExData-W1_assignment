#library(data.table)

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "data/data.zip", method="curl")
unzip("data/data.zip", exdir ="data")

filePath = "data/household_power_consumption.txt"
df <- read.table(filePath, header = TRUE, sep=";", na.strings = "?")

df$Date <- as.Date(df$Date, "%d/%m/%Y")

df <- subset(df,Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## Combine Date and Time column
dateTime <- paste(df$Date, df$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
df <- df[ ,!(names(df) %in% c("Date","Time"))]

## Add DateTime column
df <- cbind(dateTime, df)

## Format dateTime Column
df$dateTime <- as.POSIXct(dateTime)

plot(t$Global_active_power~t$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
