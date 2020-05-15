setwd("C:/melfaiz/DataAnalysis")
library(dplyr)
library(ggplot2)
data <- read.csv("january_2018_all.csv",header = TRUE)

AIRPORT_ID <- 10721 # "Boston, MA: Logan International"
data_filtered <- subset(data,  OriginAirportID == AIRPORT_ID & Cancelled == 0 &  Diverted == 0 & DepDel15 == 1)


# 
# data_filtered <- select(data_filtered,DepDelayMinutes,WeatherDelay,CarrierDelay,NASDelay,SecurityDelay,LateAircraftDelay )
# 
# data_filtered = na.omit(data_filtered)
# 
# MeanDepDelayMinutes = mean( data_filtered$DepDelayMinutes)
# MeanWeatherDelay = mean( data_filtered$WeatherDelay)
# MeanCarrierDelay = mean( data_filtered$CarrierDelay)
# MeanNASDelay = mean( data_filtered$NASDelay)
# MeanSecurityDelay = mean( data_filtered$SecurityDelay)
# MeanLateAircraftDelay = mean( data_filtered$LateAircraftDelay)
# 
# 
# summary <- data_filtered %>% summarise_each(funs(mean))
# names <- colnames(data_filtered)
# 
# barplot(summary[,], main="DEKAYS", names = names)


write.csv(data_filtered,"data_filtered.csv", row.names = FALSE)
