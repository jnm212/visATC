# put scraped WHO data from
# https://github.com/fabkury/atcd/releases/tag/april2026
# in /data folder:

df <- readr::read_csv(file="./inst/extdata/WHO.ATC-DDD.2026-04-25.csv",
                        col_types=list("character","character", "double", "character", "double", "double"))

ATCdata <- df$atc_code
names(ATCdata) <- df$atc_name

usethis::use_data(ATCdata,  overwrite = TRUE)
