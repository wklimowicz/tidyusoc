cli_converting_complete <- function(output_directory) {
  cli::cli_div(theme = list(span.emph = list(color = "orange")))

  cli::cli_alert_success("Converting complete")

  cli::cli_alert_info("Run compiling on new folder with {.emph usoc_compile('{output_directory}')}\n")

  cli::cli_end()
}
