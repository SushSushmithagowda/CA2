getwd()

library(readr)
library(dplyr)
files <- list.files(path = "C:/Users/Lenovo/Downloads/NI Crime Data/NI Crime Data", pattern =
                      "*.csv", full.names = T)

All_crimeNI <- sapply(files, read_csv, simplify = FALSE) %>% bind_rows(.id="id")
All_crimeNI