#' Reformat data
#'
#' @param data_folder_path path to the csv file downloaded from LACDPH vaccination website
#'
#' @return a tibble containing the variables of interset
#' @export
#'
#'
#' @importFrom fs path
#' @importFrom dplyr mutate lag arrange group_by
#' @importFrom readr read_csv cols col_date
#' @importFrom magrittr %<>% %>%

load_data = function(
  data_folder_path = fs::path(
    "inst/extdata",
    "LAC_Vaccine_City_Data.csv")
)
{

  data1 = readr::read_csv(data_folder_path,
                          na = c("", "NA", "Unreliable Data" , "--"),
                          col_types =
                            readr::cols(
                              `Number all Vaccinated (Dose 1+)` = col_number(),
                              `Cumulative all (Dose 1+)` = col_number(),
                              # `Cumulative Percentage all (Dose 1+)` = col_number(),
                              `Number all Vaccinated (Fully vaccinated)` = col_number(),
                              `Cumulative all (Fully vaccinated)` = col_number(),
                              # `Cumulative Percentage all (Fully vaccinated)` = col_number(),
                              `Number all Vaccinated (Received 1+ additional dose)` = col_number(),
                              `Cumulative all (Received 1+ additional dose)` = col_number(),


                              Date = readr::col_date(format = "%m/%d/%y")
                              # `Cumulative 65+ (Dose 1+)` = parse_number(na = "Unreliable Data")
                              # `Cumulative Percentage 65+ (Dose 1+)` = col_number()
                            ))

  data1 %<>%
    dplyr::arrange(Date) %>%
    dplyr::group_by(Community) %>%
    tidyr::fill(`Cumulative 65+ (Dose 1+)`, `Cumulative 12-17 (Dose 1+)`, `Cumulative 12+ (Dose 1+)`) %>%
    ungroup() %>%
    dplyr::mutate(

    pct65 = `Cumulative 65+ (Dose 1+)`/`Population (65+)` * 100,

    `Population (18-64)` = `Population (12+)` - `Population (12-17)` - `Population (65+)`,

    `Cumulative 18-64 (Dose 1+)` = `Cumulative 12+ (Dose 1+)` - `Cumulative 12-17 (Dose 1+)` - `Cumulative 65+ (Dose 1+)`,

    `pct18-64` = `Cumulative 18-64 (Dose 1+)` / `Population (18-64)` * 100,

    `% vaccinated 12-17` = `Cumulative 12-17 (Dose 1+)` / `Population (12-17)` * 100) %>%
    dplyr::group_by(Community) %>%
    dplyr::arrange(Date) %>%
    dplyr::mutate(
      `new vax 65+` = `Cumulative 65+ (Dose 1+)` - dplyr::lag(`Cumulative 65+ (Dose 1+)`),

      `new vax 18-64` = `Cumulative 18-64 (Dose 1+)` - dplyr::lag(`Cumulative 18-64 (Dose 1+)`),

      `new vax 12-17` = `Cumulative 12-17 (Dose 1+)` - dplyr::lag(`Cumulative 12-17 (Dose 1+)`)

    )

  return(data1)
}
