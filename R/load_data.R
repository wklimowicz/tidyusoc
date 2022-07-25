#' Load USOC from DATA_DIRECTORY folder
#'
#' To be able to use one file across many projects,
#' set an environment variable called `DATA_DIRECTORY` with a folder path,
#' and use this function to load the data in.
#'
#' @param as.data.table Passed to read_fst
#' @param ... Passed to fst::read_fst
#'
#' @export
usoc_load <- function(as.data.table = TRUE, ...) {

  # Check if DATA_DIRECTORY environment variable is present
  if (Sys.getenv("DATA_DIRECTORY") == "") {
    cli::cli_alert_danger("You don't have the DATA_DIRECTORY environment variable set: see the help for `usoc_compile`.")

    stop()
  }

  fst::read_fst(paste0(Sys.getenv("DATA_DIRECTORY"), "/usoc_data.fst"),
    as.data.table = as.data.table,
    ...
  )
}
