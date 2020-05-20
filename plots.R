setwd("C://Users//ANDREA//Documents//DataAnalysis")

library(ggplot2)
library(GGally)

data <- read.csv("data.csv",header = TRUE)
data$X <- NULL
data <- na.omit(data)

ggplot(data, aes(x=DEP_DELAY_NEW, y=ARR_DELAY_NEW)) + geom_point(color="#1CACDB") + geom_smooth(method=lm , color="red", se=FALSE) + ggtitle("January Departure vs Arrival Delays") + xlab("Departure Delay") + ylab("Arrival Delay")

plot(data$DEP_DELAY_NEW,data$ARR_DELAY_NEW,main = "January Departure vs Arrival Delays", xlab = "Departure Delays",
     ylab = "Arrival Delays", col="#1CACDB", pch=19);grid()

# Delay reason vs Month 
delays_january  <- read.csv("Delays_January.csv",header = TRUE)
delays_january$X <- NULL
delays_january <- na.omit(delays_january)
attach(delays_january)

# Change values of lim = c(0, 500) 
# Erase potential outliers ?
boxplot(CARRIER_DELAY,WEATHER_DELAY,NAS_DELAY, SECURITY_DELAY, LATE_AIRCRAFT_DELAY,
        main = "January: Cause of Delay",at = c(1,2,3,4,5),
        names = c("Carrier", "Weather", "Nas", "Security", "Late Aircraft"),
        col = c("#1CACDB","aquamarine2", "indianred1", "slategray1", "tan2"), horizontal = FALSE,
        notch = FALSE, ylim = c(0, 20));grid()

# plot(delays_january,  pch=20 , cex=1.5 , col="#69b3a2") #No 

#tips data base 
#try both 
ggpairs(tips[, c(1, 3, 4, 2)],
        upper = list(continuous = "density", combo = "box_no_facet"),
        lower = list(continuous = "points", combo = "dot_no_facet"))
ggpairs(data, title="correlogram with ggpairs()") 


library(dplyr)
library(ggplot2)

data <- read.csv("january_filterd.csv",header = TRUE)

AIRPORT_ID <- 10721 # "Boston, MA: Logan International"
data_filtered <- subset(data,  OriginAirportID == AIRPORT_ID & Cancelled == 0 &  Diverted == 0 & DepDel15 == 1)



data_filtered <- select(data_filtered,DepDelayMinutes,WeatherDelay,CarrierDelay,NASDelay,SecurityDelay,LateAircraftDelay )

data_filtered = na.omit(data_filtered)

MeanDepDelayMinutes = mean( data_filtered$DepDelayMinutes)
MeanWeatherDelay = mean( data_filtered$WeatherDelay)
MeanCarrierDelay = mean( data_filtered$CarrierDelay)
MeanNASDelay = mean( data_filtered$NASDelay)
MeanSecurityDelay = mean( data_filtered$SecurityDelay)
MeanLateAircraftDelay = mean( data_filtered$LateAircraftDelay)


summary <- data_filtered %>% summarise_each(funs(mean))
names <- colnames(data_filtered)

barplot(summary[,], main="DEKAYS", names = names)


write.csv(data_filtered,"data_filtered.csv", row.names = FALSE)

library(ggplot2)
library(GGally)
library(dplyr)
library(RColorBrewer)

setwd("C://melfaiz//DataAnalysis")

data <- read.csv("delays_summary.csv",header = TRUE)
vector       <- c(1:5)
data_delay   <- c(7.120879,	29.94976,	14.91261,	0.1193093,	33.22554)
data2 <- select(data, -DepDelayMinutes)


barplot(height=data_delay, names= colnames(data2), ylab="Values", main="Delay Reasons", col = "#1CACDB");grid()

myPalette <- brewer.pal(5, "Set2") 
pie(data_delay, labels = colnames(data2), border="white", col=myPalette )


january <- read.csv("january_filtered.csv",header = TRUE)

days <- select(january, DayOfWeek,DepDelayMinutes)
attach(days)

ggplot(days, aes(x=DayOfWeek, y=DepDelayMinutes, group = DayOfWeek)) + geom_boxplot(alpha=0.3) + theme(legend.position="none") + ggtitle("January Departure Delays vs Day of the week") + ylim(0,150) + ylab("Departure Delay Minutes") + xlab("Day of the week")  


january_filtered <- read.csv("january_filtered.csv",header = TRUE)
attach(january_filtered)
delays <- select(january_filtered, DepDel15, group = DayofMonth)
count <- count(delays, vars = DayofMonth, wt_var = DepDel15)
ggplot(count, aes(x = vars, y = n)) + geom_point(color="#1CACDB") + geom_line(color="#1CACDB") + ggtitle("January Delayed Flights") + xlab("Day of the month") + ylab("Number of flights")
