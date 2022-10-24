annotate_jbsoc_cc <- function(usoc, coding_frame) {

    jbsoc_cc_coding <- readr::read_csv(
      paste0(system.file("coding_frames", package = "tidyusoc"), "/", coding_frame, ".csv"),
      col_types = readr::cols(
        jbsoc_cc = readr::col_character(),
        jbsoc_description = readr::col_character()
      )
    ) %>%
    data.table::as.data.table() %>%
    data.table::setnames("jbsoc_cc", coding_frame)

    usoc[jbsoc_cc_coding,
         jbsoc_description := i.jbsoc_description,
         on = c(coding_frame)]


return(usoc)

}


annotate_jbstat <- function(usoc) {

    jbstat_coding <- readr::read_csv(
      paste0(system.file("coding_frames", package = "tidyusoc"), "/jbstat.csv"),
      col_types = readr::cols(
        jbstat = readr::col_character(),
        ilo = readr::col_character()
      )
    ) %>%
    data.table::as.data.table()

    usoc[jbstat_coding,
         ilo := i.ilo,
         on = "jbstat"]

    usoc[age < 17,
         ilo := "Under 16"]

return(usoc)

}
