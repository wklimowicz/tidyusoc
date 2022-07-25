skip_on_ci()


test_that("Local data matches website", {

  url <- "https://www.understandingsociety.ac.uk/documentation/mainstage/dataset-documentation/variable/race"

  # Supress windows warning about UTF8
  suppressWarnings({
  url_bow <- polite::bow(url, verbose = FALSE)
  })

  race_table_web <- polite::scrape(url_bow) %>%
    rvest::html_nodes("table.table.table-striped") %>%
    rvest::html_table(fill = TRUE) %>%
    purrr::pluck(12) %>%
    dplyr::select(1, 3) %>%
    dplyr::rename("race" = 1, "N" = 2) %>%
    dplyr::arrange(N) %>%
    tibble::as_tibble()

  usoc <- usoc_load()

  race_table_usoc <- usoc[wave == "ba", .N, .(race = as.character(race))][order(N)] |>
    janitor::adorn_totals(name = "") %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), as.vector)) %>%
    tibble::as_tibble()


  expect_equal(race_table_web, race_table_usoc)
})
