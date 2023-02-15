convert_save_file <- function(original_file_path, save_file_path) {

  cli::cli_alert_info(paste("converting", original_file_path))

  df <- haven::read_sav(original_file_path)

  saveRDS(df, save_file_path)

}


#' Convert USOC files to RDS
#'
#' @param usoc_directory Directory of top level USOC data (where "bhps" and "ukhls" are)
#' @param new_directory Directory where RDS files will be saved
#' @param incremental Only convert files that don't already exist in output
#' @param filter_files regex to narrow files, e.g. "indresp"
#'
#' @export
usoc_convert <- function(usoc_directory,
                         new_directory,
                         incremental = TRUE,
                         filter_files = NULL) {

  cli::cli_h1("Converting BHPS")

  usoc_convert_directory(paste0(usoc_directory, "/bhps"),
    paste0(new_directory, "/bhps"),
    new_directory,
    filter_files = filter_files,
    incremental = incremental
  )

  cli::cli_h1("Converting UKHLS")
  usoc_convert_directory(paste0(usoc_directory, "/ukhls"),
    paste0(new_directory, "/ukhls"),
    new_directory,
    filter_files = filter_files,
    incremental = incremental
  )

  # Print complete message
  cli_converting_complete(
    output_directory = new_directory
  )
}


#' @importFrom rlang .data
#' @importFrom haven labelled
usoc_convert_directory <- function(usoc_directory,
                                   output_directory,
                                   top_level_dir,
                                   incremental,
                                   filter_files) {
  . <- NULL # Fix R CMD Check

  files_in_directory <- list.files(usoc_directory)

  if (incremental == TRUE) {
    
    # Exclude files already present in output
    files_in_directory_no_ext <- list.files(usoc_directory) |>
    tools::file_path_sans_ext()

    files_in_new_directory_no_ext <- list.files(output_directory) |>
    tools::file_path_sans_ext()

    files_in_directory <- files_in_directory[!files_in_directory_no_ext %in% files_in_new_directory_no_ext]

    if (length(files_in_directory) == 0) {

      cli::cli_alert_danger("No New Files Found - set `incremental = FALSE` if you want to reconvert existing files")

      return()

    }

  }

  if (!is.null(filter_files)) {
    files_in_directory <- files_in_directory %>%
      .[grepl(filter_files, .)]
  }

  if (length(files_in_directory) == 0) {
    cli::cli_alert_danger("No Files Found")
    invokeRestart("abort")
  }

  # Create directories
  dir.create(file.path(top_level_dir), showWarnings = FALSE)
  dir.create(file.path(output_directory), showWarnings = FALSE)

  cli::cli_alert_info("Found {length(files_in_directory)} file{?s} in directory")

  correct_file_index <- stringr::str_detect(
    files_in_directory,
    "sav$"
  )

  # Take only files which match "4 digits Q digit" pattern
  usoc_files <- files_in_directory[correct_file_index]

  file_format <- tools::file_ext(files_in_directory)[correct_file_index]

  if ("Rds" %in% file_format) {
    cli::cli_alert_danger("Rds file format indicates you've already converted these files")
    invokeRestart("abort")
  }

  # Add path
  usoc_files_w_path <- file.path(usoc_directory, usoc_files)

  cli::cli_alert_info("Converting to Rds")

  # Tidy each dataset ----------------------------------------

  purrr::map(cli::cli_progress_along(usoc_files_w_path),
    usoc_convert_file,
    total_files = usoc_files_w_path,
    file_format = file_format[[1]], # simple
    output_directory = output_directory,
    file_names = usoc_files
  )


  cli::stop_app()
}


usoc_convert_file <- function(file,
                              total_files,
                              file_format,
                              file_names,
                              output_directory) {
  file_path <- total_files[[file]]

  df2 <- haven::read_sav(file_path)

  save_file_path <- paste0(
    output_directory,
    "/",
    tools::file_path_sans_ext(file_names[[file]]),
    ".Rds"
  )

  connection <- gzfile(save_file_path, compression = 1)
  on.exit(close(connection))

  saveRDS(df2, connection)

  return(NULL)
}
