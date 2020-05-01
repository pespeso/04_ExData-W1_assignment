## Script 1


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

hist(df$Global_active_power,
     main="Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col="red")

# Export the generated plot to png file, with required dimensions
dev.copy(png,"plot1.png", width=480, height=480)

# Turn off the device
dev.off()