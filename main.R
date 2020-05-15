setwd("C://Users//ANDREA//Documents//DataAnalysis")
library(readr)


files <- list.files(path = "data/performance/", pattern = "*.csv", full.names = TRUE, recursive = FALSE)


AIRPORT_ID <- 10721 # "Boston, MA: Logan International"

df_performance <- data.frame()

hour <- function(time){
  time <- as.numeric(time %/% 100)
  if (time == 0) {
    return(24);
  }
  return(time)
}

for (file in files) {
  df_performance_new <- read.csv(file, stringsAsFactors = FALSE)
  
  # The analysis will only focus on non-canceled and non-diverted flights with the
  # assigned airports as origin or destination.
  
  df_performance_new <- subset(df_performance_new,  (ORIGIN_AIRPORT_ID == AIRPORT_ID) & CANCELLED == 0 &  FLIGHTS == 1)
 
  # Change from HHMM to HH reducing classes number to 24
  
  df_performance_new$CRS_DEP_TIME  <- hour(df_performance_new$CRS_DEP_TIME )

  df_performance_new$CANCELLED <- NULL
  df_performance_new$FLIGHTS <- NULL
  df_performance_new$X <- NULL

  

  df_performance <- rbind(df_performance , df_performance_new);
  
  
  
  
}


df_performance[is.na(df_performance)] <- 0



columns_names <- colnames(df_performance)

new_order <- c("QUARTER","MONTH","DAY_OF_MONTH",
               "TAIL_NUM",
               "ORIGIN_AIRPORT_ID","DEST_AIRPORT_ID",
               "CRS_DEP_TIME",
               "DEP_DELAY_NEW","DEP_DEL15")

df_performance <- df_performance[, new_order]

names(df_performance)[3] <- "DAY"
names(df_performance)[4] <- "TAIL_NUM"
names(df_performance)[6] <- "DESTINATION_AIRPORT_ID"
names(df_performance)[7] <- "DEPARTURE_TIME"
names(df_performance)[8] <- "DELAY"
names(df_performance)[9] <- "IS_DELAY_15"



df_aircraft <- read.csv("data/aircraft_2018.csv", stringsAsFactors = FALSE)

df_performance_aircraft <-merge(x=df_performance,y=df_aircraft,by="TAIL_NUM",all.x=TRUE)



df_carrier <- read.csv("data/new_carrier_2018.csv", stringsAsFactors = FALSE)

df_performance_aircraft_carrier <-merge(x=df_performance_aircraft,y=df_carrier,by="AIRLINE_ID",all.x=TRUE)


df_performance_aircraft_carrier$TAIL_NUM <- NULL
df_performance_aircraft_carrier <- subset(df_performance_aircraft_carrier, IS_OPERATING == 'Y')


write.csv(df_performance_aircraft_carrier,"fligth_delay_analysis_2018.csv", row.names = FALSE)



