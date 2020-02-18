
length(unique(air_quality_data$sds011id))
length(unique(air_quality_data$obsid))
length(unique(air_quality_data$dhtid))

## check if the DHT ID is one-to-one with the SDS ID
length(unique(paste(air_quality_data$sds011id, air_quality_data$dhtid)))
