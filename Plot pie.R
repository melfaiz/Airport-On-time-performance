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
