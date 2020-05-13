df_carrier <- read.csv("data/carrier_2018.csv", stringsAsFactors = FALSE)

df_carrier_mean <- aggregate( x =df_carrier$FULLTIME_EMPLOYEES,
                              by = list(df_carrier$AIRLINE_ID),
                              mean)

df_carrier_mean$x = as.integer(df_carrier_mean$x)


names(df_carrier_mean)[1] <- "AIRLINE_ID"
names(df_carrier_mean)[2] <- "FULLTIME_EMPLOYEES"

df_carrier$FULLTIME_EMPLOYEES <- NULL
df_carrier$MONTH <- NULL



df_carrier <-merge(x=df_carrier_mean,y=df_carrier,by="AIRLINE_ID", all.x = TRUE)

df_carrier = unique(df_carrier)

write.csv(df_carrier,"data/carrier_2018.csv", row.names = FALSE)
