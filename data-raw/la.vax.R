
library(tidyverse)
library(fs)
library(LA.Vax.Data)
data_folder_path = path("inst/extdata/",  "LAC_Vaccine_City_Data.csv")
la.vax = load_data()

usethis::use_data(la.vax, overwrite = TRUE)
