#' Picks column names in order of appearance
#'
#' When column names change over time, picks the first
#' one that appears from the list in order of appearance.
#' If it doesn't appear, returns a character NA.
#'
#' @param vector_of_names character vector of column names
#' @param column_names vector of columns from usoc
#'
#' @return First name that appears in cols
#'
#' @export
pick <- function(vector_of_names, column_names) {
  index <- vector_of_names %in% column_names

  if (sum(index) > 0) {
    vector_of_names[which.max(index == T)]
  } else {
    NA_character_
  }
}


usoc_default_mappings <- function(cols) {

  age <- pick(c("age", "age_dv"), cols)
  sex <- pick(c("sex", "sex_dv"), cols)
  race <- pick(c("race", "racel_dv"), cols)
  industry <- pick(c("jbsic", "jbsic07_cc"), cols)

  variables <- tibble::tribble(
    ~usoc_name, ~new_name, ~type,
    # ID Variables --------------------
    "pidp", "pidp", "numeric",
    "hidp", "hidp", "numeric",
    "pno", "pno", "numeric",
    sex, "sex", "factor",
    age, "age", "numeric",
    race, "race", "factor",
    "country", "country", "factor",
    "gor_dv", "gor_dv", "factor",
    "qfhigh_dv", "qfhigh_dv", "factor",
    "hiqual_dv", "hiqual_dv", "factor",
    "jbstat", "jbstat", "factor",
    "jbsoc90_cc", "jbsoc90_cc", "character",
    "jbsoc00_cc", "jbsoc00_cc", "character",
    "jbsoc10_cc", "jbsoc10_cc", "character",
    industry, "industry", "factor",
    "fimnlabgrs_dv", "fimnlabgrs_dv", "numeric",
  )

  # Exclude missing
  variables <- variables %>%
    dplyr::mutate(usoc_name = ifelse(.data$usoc_name %in% cols,
      .data$usoc_name,
      NA
    ))

  return(variables)

}
