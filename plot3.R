## Script 3


# If file not exists, load the data source, download the file and extract it
if(!file.exists("data/data.zip")){
  message("Data does not exists, downloading…")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, "data/data.zip", method="curl")
  unzip("data/data.zip", exdir ="data")
} else {
  message("Data is already downloaded")
}
# Create a dataframe with the downloaded data.
# Separator character is ";"
# null strings are "?"
filePath = "data/household_power_consumption.txt"
df <- read.table(filePath, header = TRUE, sep=";", na.strings = "?")

# Convert Date column to Date type
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# Subset to the required dates (01-Feb-2007 and 02-Feb-2007)
df <- subset(df,Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## Create a new column `DateTime` by merging Date and Time columns
dateTime <- paste(df$Date, df$Time)
dateTime <- setNames(dateTime, "DateTime")
df <- cbind(dateTime, df)
df$dateTime <- as.POSIXct(dateTime)

## Remove old Date and Time columns
df <- df[ ,!(names(df) %in% c("Date","Time"))]

# Generate the required plot for this script
with(df, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Export the generated plot to png file, with required dimensions
dev.copy(png,"plot3.png", width=480, height=480)

# Turn off the device
dev.off()
