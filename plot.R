


setwd("C:/melfaiz/DataAnalysis")

data <- read.csv("data.csv",header = TRUE)
data$X <- NULL

data <- na.omit(data)



plot(data$DEP_DELAY_NEW,data$ARR_DELAY_NEW)
