
library(tidyverse)
library(fs)
# library(LA.Vax.Data)
load_all()
la.vax = load_data()

usethis::use_data(la.vax, overwrite = TRUE)
