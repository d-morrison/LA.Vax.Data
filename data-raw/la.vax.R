
library(tidyverse)
library(fs)
# library(LA.Vax.Data)
load_all()
la.vax = load_data()

usethis::use_data(la.vax, overwrite = TRUE)

vax.last = la.vax %>% extract_vax_last()

usethis::use_data(vax.last, overwrite = TRUE)

