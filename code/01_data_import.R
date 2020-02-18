
### AIR QUALITY DATA FROM LEUVENAIR
air_quality_data_2020 <- read_csv(file = "./data/LEUVENAIRfulldump2020.csv")
air_quality_data_2019 <- read_csv(file = "./data/LEUVENAIRfulldump2019.csv")
air_quality_data_2018 <- read_csv(file = "./data/LEUVENAIRfulldump2018.csv")

## 2020 - aggregation and simplify
air_quality_data_2020 = clean_names(air_quality_data_2020)

air_quality_data_2020 <- air_quality_data_2020 %>%
  dplyr::select(obsid, lat, lon, pm2_5, dateutc)

colnames(air_quality_data_2020) <- c("id", "point_latitude", "point_longitude", "value", "start_time")
air_quality_data_2020 <- air_quality_data_2020[complete.cases(air_quality_data_2020),]
air_quality_data_2020$start_time <- as.POSIXct(air_quality_data_2020$start_time)
air_quality_data_2020$hour <- droplevels(cut(air_quality_data_2020$start_time, breaks="hour"))
air_quality_data_2020 <- air_quality_data_2020 %>%
  ungroup() %>%
  group_by(hour, point_latitude, point_longitude) %>%
  summarize(value = mean(value, na.rm = T)) %>%
  ungroup() %>%
  mutate(start_time = hour) %>%
  dplyr::select(-hour)
air_quality_data_2020$id <- rownames(air_quality_data_2020)

## 2019 - aggregate and simplify
air_quality_data_2019 = clean_names(air_quality_data_2019)

air_quality_data_2019 <- air_quality_data_2019 %>%
  dplyr::select(obsid, lat, lon, pm2_5, dateutc)

colnames(air_quality_data_2019) <- c("id", "point_latitude", "point_longitude", "value", "start_time")
air_quality_data_2019 <- air_quality_data_2019[complete.cases(air_quality_data_2019),]
air_quality_data_2019$start_time <- as.POSIXct(air_quality_data_2019$start_time)
air_quality_data_2019$hour <- droplevels(cut(air_quality_data_2019$start_time, breaks="hour"))
air_quality_data_2019 <- air_quality_data_2019 %>%
  ungroup() %>%
  group_by(hour, point_latitude, point_longitude) %>%
  summarize(value = mean(value, na.rm = T)) %>%
  ungroup() %>%
  mutate(start_time = hour) %>%
  dplyr::select(-hour)
air_quality_data_2019$id <- rownames(air_quality_data_2019)

## 2018 - aggregation and simplify
air_quality_data_2018 = clean_names(air_quality_data_2018)

air_quality_data_2018 <- air_quality_data_2018 %>%
  dplyr::select(obsid, lat, lon, pm2_5, dateutc)

colnames(air_quality_data_2018) <- c("id", "point_latitude", "point_longitude", "value", "start_time")
air_quality_data_2018 <- air_quality_data_2018[complete.cases(air_quality_data_2018),]
air_quality_data_2018$start_time <- as.POSIXct(air_quality_data_2018$start_time)
air_quality_data_2018$hour <- droplevels(cut(air_quality_data_2018$start_time, breaks="hour"))
air_quality_data_2018 <- air_quality_data_2018 %>%
  ungroup() %>%
  group_by(hour, point_latitude, point_longitude) %>%
  summarize(value = mean(value, na.rm = T)) %>%
  ungroup() %>%
  mutate(start_time = hour) %>%
  dplyr::select(-hour)
air_quality_data_2018$id <- rownames(air_quality_data_2018)

air_quality_data_aggregated = rbind(air_quality_data_2018, air_quality_data_2019, air_quality_data_2020)
## Merge dataframes into single dataframe
write.csv(air_quality_data_aggregated, "air_quality_formattted_data_kepler_gl.csv")

### CAMERA DATA FROM TELRAAM
url = "https://telraam-api.net/v0/cameras"

#r <- GET(url = url)
#r = content(r, as = "parsed", type = "application/json")
df <- fromJSON(url)
camera_df <- data.frame(df)


