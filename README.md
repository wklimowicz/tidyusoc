
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidyusoc

<!-- badges: start -->

[![R-CMD-check](https://github.com/wklimowicz/tidyusoc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/wklimowicz/tidyusoc/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Installation

You can install the development version of tidyusoc from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("wklimowicz/tidyusoc")
```

## Setup

After downloading the Understanding Society Data from the UK Data
Service website, run:

``` r
library(tidyusoc)

# Convert to Rds to save space and time
usoc_convert(usoc_directory = "spss/spss25",
             new_directory = "rds",
             filter_files = "indresp")

# Compile the INDRESP files in the rds folder
usoc <- usoc_compile(directory = "rds")
```

A small set of core variables is included by default:

| Variable      | Description                                  |
|:--------------|:---------------------------------------------|
| pidp          | Personal ID                                  |
| age           | Age                                          |
| race          | Race/Ethnicity                               |
| sex           | Sex                                          |
| country       | Country                                      |
| gor_dv        | Government Office Region                     |
| qfhigh_dv     | Highest Qualification (Detailed, UKHLS Only) |
| hiqual_dv     | Highest Qualification                        |
| jbstat        | Job Status                                   |
| jbsoc00_cc    | Occupation                                   |
| fimnlabgrs_dv | Labour Income                                |

To add more variables, use the `extra_mappings` function. For variables
that change over time use `pick`. For example, life satisfaction is:

-   `lfsato` in waves 6-10 and 12-18 of the BHPS.
-   `sclfsato` in waves 1-11 of the UKHLS.

The variable BMI (`bmi_dv`) doesn’t change over time, so it’s passed as
a string.

``` r
custom_mappings <- function(cols) {

    life_sat <- pick(c("sclfsato", "lfsato"), cols)

    custom_variables <- tibble::tribble(
        ~usoc_name, ~new_name, ~type,
        life_sat, "life_satisfaction", "factor",
        "bmi_dv", "bmi_dv", "numeric"
    )

    return(custom_variables)

}

usoc <- usoc_compile("rds", extra_mappings = custom_mappings)
```

A good place to start looking for variables is the [Understanding
Society Variable
Search](https://www.understandingsociety.ac.uk/documentation/mainstage/dataset-documentation),
and the
[Documentation](https://www.understandingsociety.ac.uk/documentation).

## Compiling different surveys.

By default, these scripts compile the `indresp` file - you can change
this with the `file` argument. For example, to compile the `youth`
response files:

``` r
usoc_convert(usoc_directory = "spss/spss25",
             new_directory = "rds",
             filter_files = "youth")

usoc <- usoc_compile(directory = "rds", file = "youth")
```

## Using the data across multiple projects.

Adding an environment variable called `DATA_DIRECTORY` pointing at a
folder, automatically saves an fst of the final dataset, so it can be
loaded from anywhere using:

``` r
library(tidyusoc)
usoc <- usoc_load()
```

To read any of the other compiled files change the argument:

``` r
usoc <- usoc_load(file = "youth")
```
