library(dplyr)
library(lubridate)

# Load zip file if there is no downloaded data
if (!exists('data_init')){
  url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(url, 'data.zip')
  
  # Unzip file and read text file
  unzip('data.zip')
  data_init <- read.table('household_power_consumption.txt',header = TRUE,
                          sep = ';')
  
  # Subset the data
  # Combine Date and Time and make new column 'DT'
  # Change data in character to Numeric
  
  data <- data_init %>% 
    subset((Date=='1/2/2007'|Date=='2/2/2007')) %>%
    mutate(DT=paste(Date,Time)) %>% # paste together Date and Time
    mutate(DT=dmy_hms(DT)) %>% # Change them into Date class and assign them to new column
    mutate(Global_active_power=as.numeric(Global_active_power), # Change data in chr to numeric
           Global_reactive_power=as.numeric(Global_reactive_power),
           Voltage=as.numeric(Voltage),
           Global_intensity=as.numeric(Global_intensity),
           Sub_metering_1=as.numeric(Sub_metering_1),
           Sub_metering_2=as.numeric(Sub_metering_2),
           Sub_metering_3=as.numeric(Sub_metering_3),) 
}


# Plot and save it as png file
plot.new()
with(data, plot(DT, Sub_metering_1,type='l',xlab='',ylab='Energy sub metering'))
with(data, lines(DT, Sub_metering_2,type='l',col='red'))
with(data, lines(DT, Sub_metering_3,type='l',col='blue'))
legend('topright',
       lty=1,
       col=c('black','red','blue'),
       legend=c('Sub_metering_1',
                'Sub_metering_2',
                'Sub_metering_3'),
       cex=.75) # for the size the box of legend

dev.copy(png,'plot3.png')
dev.off()      

