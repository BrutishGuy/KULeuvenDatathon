
### AIR QUALITY DATA FROM LEUVENAIR
air_quality_data <- read_csv(file = "./data/LEUVENAIRfulldump2020.csv")
air_quality_data = clean_names(air_quality_data)

url = "https://telraam-api.net/v0/cameras"

#r <- GET(url = url)
#r = content(r, as = "parsed", type = "application/json")
df <- fromJSON(url)
camera_df <- data.frame(df)

air_quality_formatted_data <- air_quality_data %>%
  dplyr::select(obsid, lat, lon, pm2_5, dateutc)

colnames(air_quality_formatted_data) <- c("id", "point_latitude", "point_longitude", "value", "start_time")
air_quality_formatted_data <- air_quality_formatted_data[complete.cases(air_quality_formatted_data),]
air_quality_formatted_data$start_time <- as.POSIXct(air_quality_formatted_data$start_time)
air_quality_formatted_data$hour <- droplevels(cut(air_quality_formatted_data$start_time, breaks="hour"))
air_quality_formatted_data <- air_quality_formatted_data %>%
  ungroup() %>%
  group_by(hour, point_latitude, point_longitude) %>%
  summarize(value = mean(value, na.rm = T)) %>%
  ungroup() %>%
  mutate(start_time = hour) %>%
  dplyr::select(-hour)
air_quality_formatted_data$id <- rownames(air_quality_formatted_data)
write.csv(air_quality_formatted_data, "air_quality_formattted_data_kepler_gl.csv")
