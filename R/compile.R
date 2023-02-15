#' Compile Understanding Society SPSS files to one dataset
#'
#' Compiles all files from BHPS and UKHLS into one file
#'
#' To automatically save this file in a directory to be used
#' between projects, set a system variable called `DATA_DIRECTORY`
#' pointing at a folder.
#'
#' To do that just for R sessions, add the line below to .Rprofile:
#'
#' `Sys.setenv(DATA_DIRECTORY = "~/path/to/folder")`
#'
#' @param directory Directory with `bhps/` and `ukhls/`
#' @param extra_mappings function with extra columns to compile
#' @param save_variables_report Save a csv with a summary of variables?
#' @param save_to_folder If TRUE, will save to the `DATA_DIRECTORY` environment variable if present
#' @param file Which file of the usoc data to compile? By default `indresp`,
#' but also works on youth, child, etc.
#'
#' @export
usoc_compile <- function(directory,
                         extra_mappings = NULL,
                         save_variables_report = TRUE,
                         save_to_folder = FALSE,
                         file = "indresp") {

  # R CMD Check
  wave <- waveid <- NULL

  bhps_directory <- paste0(directory, "/bhps")
  ukhls_directory <- paste0(directory, "/ukhls")

  bhps_waves <- get_bhps_waves(bhps_directory)
  ukhls_waves <- get_ukhls_waves(ukhls_directory)

    # Take only files that exist

  bhps_existing <- c(paste0(bhps_directory, "/", bhps_waves, "_", file, ".Rds"))
  bhps_waves <- bhps_waves[file.exists(bhps_existing)]

  ukhls_existing <- c(paste0(ukhls_directory, "/", ukhls_waves, "_", file, ".Rds"))
  ukhls_waves <- ukhls_waves[file.exists(ukhls_existing)]


  bhps_files <- lapply(bhps_waves,
    compile_usoc_file,
    path = directory,
    ending = file,
    survey = "bhps",
    extra_mappings = extra_mappings
  )

  ukhls_files <- lapply(ukhls_waves,
    compile_usoc_file,
    path = directory,
    ending = file,
    survey = "ukhls",
    extra_mappings = extra_mappings
  )

    
  usoc_files <- c(purrr::map(bhps_files, 1), purrr::map(ukhls_files, 1))
  usoc_mapping <- c(purrr::map(bhps_files, 2), purrr::map(ukhls_files, 2))


  if (save_variables_report == TRUE) {

    final_mapping <- usoc_mapping[[1]][[2]]

    variables_report <- usoc_mapping %>%
      purrr::map("usoc_name")

    names(variables_report) <- c(bhps_waves, ukhls_waves)

    variables_report <- dplyr::bind_rows(variables_report, .id = "WAVE")
    variables_report <- base::t(variables_report)
    variables_report <- as.data.frame(variables_report)

    variables_report <- variables_report %>%
      dplyr::mutate(wave = row.names(variables_report)) %>%
      dplyr::relocate("wave")

    colnames(variables_report) <- c("wave", final_mapping)

    save_name_mapping <- paste0("usoc_", file, "_variables_report.csv")

    # If file is open, give warning and continue
    tryCatch(
      {
        readr::write_csv(variables_report, file = save_name_mapping)
      },
      error = function(cond) {
        cli::cli_alert_danger("usoc_variables_report.csv is open - close it and rerun to get the report")
      }
    )
  }

  wave_letter <- c(bhps_waves, ukhls_waves)
  names(usoc_files) <- wave_letter

  usoc_files <- data.table::rbindlist(usoc_files, fill = TRUE, idcol = "wave")

  wave_year_mapping <- data.table::fread(system.file("coding_frames/wave_year.csv",
    package = "tidyusoc"
  ))

  usoc_files <- merge(usoc_files,
    wave_year_mapping,
    by = "wave",
    all.x = TRUE,
    sort = FALSE
  )

  main_vars <- c("wave", "waveid", "year", "pidp")
  main_vars <- main_vars[main_vars %in% names(usoc_files)]
  # Reorder columns
  data.table::setcolorder(usoc_files, main_vars)

 usoc_files[, `:=`(
                    wave = factor(wave, levels = wave_letter, ordered = TRUE),
                    waveid = factor(waveid, levels = wave_year_mapping$waveid, ordered = TRUE)
                    )]


 # File level annotations

 if (file == "indresp") {

   usoc_files %>%
    annotate_jbstat()

   if ("jbsoc90_cc" %in% names(usoc_files)) {
     usoc_files %>%
      annotate_jbsoc_cc("jbsoc90_cc")
   }

   if ("jbsoc00_cc" %in% names(usoc_files)) {
     usoc_files %>%
      annotate_jbsoc_cc("jbsoc00_cc")
   }

 }

  # Give the file the file name
    save_name <- paste0("usoc_", file, "_data.fst")

 # If enabled
  if (save_to_folder == TRUE) {

  # If DATA_DIRECTORY environment variable is present, save there.
  if (Sys.getenv("DATA_DIRECTORY") != "") {
    fst::write_fst(
      usoc_files,
      paste0(Sys.getenv("DATA_DIRECTORY"), "/", save_name)
    )

    cli::cli_alert_info("DATA_DIRECTORY environment variable set - saving in folder")
  }

  }

  return(usoc_files)
}


read_usoc_file <- function(wave, ending, survey, path) {
  extension <- "Rds"

  file_name <- paste0(path, "/", survey, "/", wave, "_", ending, ".", extension)

  usoc <- readRDS(file_name) |>
    data.table::setDT()

  drop_prefix(usoc, wave, survey)

  return(usoc)
}


compile_usoc_file <- function(wave, ending, survey, path, extra_mappings) {

  cli::cli_alert_info(paste0("Compiling wave ", wave, " from ", survey))

  usoc <- read_usoc_file(wave, ending, survey, path)

  cols <- colnames(usoc)
  complete_mappings <- usoc_default_mappings(cols)

  # Take extra mappings if present
  if (!is.null(extra_mappings)) {
    vars_extra <- extra_mappings(cols)

    vars_extra <- vars_extra %>%
      dplyr::mutate(usoc_name = ifelse("usoc_name" %in% cols, "usoc_name", NA))

    # Remove existing mappings if overwritten
    complete_mappings <- complete_mappings %>%
      dplyr::filter(!"new_name" %in% vars_extra[[2]])

    complete_mappings <- dplyr::bind_rows(complete_mappings, vars_extra)
  }

  # Only take the variables that are present in the file
  vars_present <- complete_mappings$usoc_name[complete_mappings$usoc_name %in% cols]

  df3 <- usoc %>%
    dplyr::select(dplyr::all_of(vars_present)) %>%
    dplyr::distinct()

  new_names <- complete_mappings$new_name[complete_mappings$usoc_name %in% vars_present]

  colnames(df3) <- new_names
  stopifnot(length(colnames(df3)) == sum(complete_mappings$usoc_name %in% cols))


  factor_variables <- ifelse(complete_mappings$type == "factor", complete_mappings$new_name, NA)
  factor_variables <- factor_variables[!is.na(factor_variables)]

  numeric_variables <- ifelse(complete_mappings$type == "numeric", complete_mappings$new_name, NA)
  numeric_variables <- numeric_variables[!is.na(numeric_variables)]

  character_variables <- ifelse(complete_mappings$type == "character", complete_mappings$new_name, NA)
  character_variables <- character_variables[!is.na(character_variables)]

  # Not used currently
  # unlabelled_factor_variables <- ifelse(complete_mappings$type == "unlabelled_factor", complete_mappings$new_name, NA)
  # unlabelled_factor_variables <- unlabelled_factor_variables[!is.na(unlabelled_factor_variables)]


  # Convert all to factor to retain labels,
  df3 <- df3 %>%
    dplyr::mutate(dplyr::across(
      dplyr::any_of(c(factor_variables, numeric_variables)),
      haven::as_factor
    ))

  # Convert to numeric

  # Warnings come up since c("missing", 5") gets translate to
  # numeric which turns missing -> NA as intended.
  suppressWarnings({
    df3 <- df3 %>%
      dplyr::mutate(dplyr::across(
        dplyr::any_of(numeric_variables),
        ~ .x |>
          as.character() |>
          as.numeric()
      )) %>%
      dplyr::mutate(dplyr::across(
        dplyr::any_of(character_variables),
        ~ .x |>
          as.character()
      )
      )


  })

  return(list(df3, complete_mappings))
}
