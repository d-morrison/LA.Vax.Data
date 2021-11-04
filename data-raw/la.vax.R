
library(tidyverse)
library(fs)
# library(LA.Vax.Data)
load_all()
la.vax = load_data()

usethis::use_data(la.vax, overwrite = TRUE)

vax.last = la.vax %>%
  group_by(Community) %>%
  filter(!is.na(`% vaccinated 12-17`)) %>%
  slice_tail() %>%
  ungroup() %>%
  select(
    Community,
    `Population (12-17)`,
    `Cumulative 12-17 (Dose 1)`,
    `% vaccinated 12-17`,
    `Date (Dose 1)`) %>%
  rename(Date = `Date (Dose 1)`)

usethis::use_data(vax.last, overwrite = TRUE)

