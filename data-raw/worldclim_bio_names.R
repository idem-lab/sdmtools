# BIO1 = Annual Mean Temperature
# BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp))
# BIO3 = Isothermality (BIO2/BIO7) (×100)
# BIO4 = Temperature Seasonality (standard deviation ×100)
# BIO5 = Max Temperature of Warmest Month
# BIO6 = Min Temperature of Coldest Month
# BIO7 = Temperature Annual Range (BIO5-BIO6)
# BIO8 = Mean Temperature of Wettest Quarter
# BIO9 = Mean Temperature of Driest Quarter
# BIO10 = Mean Temperature of Warmest Quarter
# BIO11 = Mean Temperature of Coldest Quarter
# BIO12 = Annual Precipitation
# BIO13 = Precipitation of Wettest Month
# BIO14 = Precipitation of Driest Month
# BIO15 = Precipitation Seasonality (Coefficient of Variation)
# BIO16 = Precipitation of Wettest Quarter
# BIO17 = Precipitation of Driest Quarter
# BIO18 = Precipitation of Warmest Quarter
# BIO19 = Precipitation of Coldest Quarter

worldclim_bio_names <- c(
  "tavg_y",
  "temp_range_d",
  "isothermality",
  "temp_seasonality",
  "tmax_warm_m",
  "tmin_cold_m",
  "temp_range_y",
  "tavg_wet_q",
  "tavg_dry_q",
  "tavg_warm_q",
  "tavg_cold_q",
  "precip_y",
  "precip_wet_m",
  "precip_dry_m",
  "precip_seasonality",
  "precip_wet_q",
  "precip_dry_q",
  "precip_warm_q",
  "precip_cold_q"
)

usethis::use_data(worldclim_bio_names, overwrite = TRUE)
