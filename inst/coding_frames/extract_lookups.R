# load_all()
library(tidyverse)

setwd(here::here())

labels_to_data_frame <- function(lab) {
x <- haven::print_labels(lab)
x2 <- attributes(x)$labels
name <- attributes(x)$labels
nx <- attributes(name) %>%
    as.data.frame()

z <- data.frame(jbsoc00_cc = x2, jbsoc_description = nx$names) 
return(z)
}

s <- haven::read_sav("../usoc_raw_data//spss25/ukhls/a_indresp.sav")
z <- labels_to_data_frame(s$a_jbsoc00_cc)

z %>%
    readr::write_csv("inst/coding_frames/jbsoc00_cc.csv")
