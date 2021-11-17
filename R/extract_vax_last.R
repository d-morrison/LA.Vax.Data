#' Title
#'
#' @param la.vax
#'
#' @return
#' @export
extract_vax_last = function(la.vax)
{
  la.vax %>%
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

}
