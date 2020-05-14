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
        notch = FALSE, ylim = c(0, 100));grid()

# plot(delays_january,  pch=20 , cex=1.5 , col="#69b3a2") #No 

#tips data base 
#try both 
ggpairs(tips[, c(1, 3, 4, 2)],
        upper = list(continuous = "density", combo = "box_no_facet"),
        lower = list(continuous = "points", combo = "dot_no_facet"))
ggpairs(data, title="correlogram with ggpairs()") 