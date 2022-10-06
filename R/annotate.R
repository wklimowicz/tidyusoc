annotate_jbsoc00_cc <- function(usoc) {

    jbsoc00_cc_coding <- readr::read_csv(
      paste0(system.file("coding_frames", package = "tidyusoc"), "/jbsoc00_cc.csv"),
      col_types = readr::cols(
        jbsoc00_cc = readr::col_integer(),
        jbsoc_description = readr::col_character()
      )
    ) %>%
    data.table::as.data.table()

    usoc[jbsoc00_cc_coding,
         jbsoc_description := i.jbsoc_description,
         on = "jbsoc00_cc"]


return(usoc)

}
