get_ukhls_waves <- function(directory) {
  list.files(directory) |>
    stringr::str_subset("indresp") |>
    substr(1, 1)
}

get_bhps_waves <- function(directory) {
  list.files(directory) |>
    stringr::str_subset("indresp") |>
    substr(1, 2)
}

#' @importFrom data.table `:=`
drop_prefix <- function(usoc, wave, survey) {

  # R CMD CHECK
  waveno <- NULL

  column_names <- names(usoc)

  prefix <- paste0(wave, "_")

  cols_with_prefix <- grepl(prefix, column_names)

  if (survey == "bhps") {
    new_names <- substr(column_names[cols_with_prefix], 4, 10000)
  } else {
    new_names <- substr(column_names[cols_with_prefix], 3, 10000)
  }


  column_names[cols_with_prefix] <- new_names

  data.table::setnames(usoc, column_names)

  return(usoc)
}
