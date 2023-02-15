library(tidyverse)
library(data.table)
library(tictoc)
library(haven)
setwd(here::here())
devtools::load_all()


usoc_convert("../spss/spss25",
             "../rds")

user_extra_mappings <- function(usoc_file_column_names) {

    # "scsf1", "scsf1", "factor",
    # "sf1", "sf1", "factor",
    # "bmi_dv", "bmi_dv", "numeric",
    # "j1soc00_cc", "j1soc00_cc", "factor",
    # "maedqf", "maedqf", "factor",
    # "masoc00_cc", "masoc00_cc", "factor",
    # "paedqf", "paedqf", "factor",
    # "pasoc00_cc", "pasoc00_cc", "factor",

    life_sat <- pick(c("sclfsato", "lfsato"), usoc_file_column_names)

  custom_variables <- tibble::tribble(
    ~usoc_name,       ~new_name,     ~type,
    "hidp", "hidp", "numeric",
    "nchild_dv", "nchild_dv", "numeric",
    "ch1by4", "ch1by4", "factor",
    "basrate", "basrate", "numeric",
    "ccare",     "ccare",    "factor",
    "mlrnot3",   "mlrnot3",  "factor",
    "xpchc",     "xpchc",    "factor",
    "jbft_dv",   "jbft_dv",  "factor", #  Full  time  or  part  time
    "jbsoc10_cc",   "jbsoc10_cc",  "factor"
    )

  return(custom_variables)
}

indresp <- usoc_compile("../rds",
                     extra_mappings = user_extra_mappings,
                     save_to_folder = TRUE,
                     file = "indresp")

# indresp[!is.na(jbsoc90_cc), .N, wave]

# indresp[!is.na(jbsoc90_cc), .N, waveid]
# indresp[!is.na(jbsoc00_cc), .N, wave]

# indresp[!is.na(jbsoc_description), .N, wave]

# indresp[, .N, jbsoc90_cc]

# indresp[!is.na(jbsoc00_cc), .N, waveid]
# indresp[!is.na(jbsoc_description), .N, waveid]

# indresp[jbsoc00_cc == 231, .N, waveid]

# indresp[jbsoc90_cc == 231, .N, wave]
# indresp[jbsoc00_cc == 231, .N, waveid]
# indresp[jbsoc10_cc == 231, .N, wave]

usoc <- usoc_compile("../rds",
                     file = "indresp")



youth_extra_mappings <- function(usoc_file_column_names) {

  custom_variables <- tibble::tribble(
    ~usoc_name,       ~new_name,     ~type,
    "yptcha", "yptcha", "factor"
    )

  return(custom_variables)

}

usoc <- usoc_compile("../rds", extra_mappings = youth_extra_mappings, file = "youth")

usoc <- usoc_load()


usoc[is.na(race), .N, wave]

s <- readRDS("rds/bhps/ba_indresp.Rds")

s %>%
    tibble()

s$ba_race


usoc[, .N, year] |> plot(type = "l")

usoc[, .N, age]
usoc[, .N, ]


usoc[, .N, sex]

usoc[, sex := fcase(sex == "female", "Female",
                    sex == "male", "Male",
                    sex == "proxy", "proxy",
                    rep(TRUE, nrow(usoc)), as.character(usoc$sex)) # Hack to recycle fcase
                     |> as.factor()]
                    
usoc[sex == "proxy", .N, wave]

s <- readRDS("rds/bhps/bp_indresp.Rds")

s$bp_sex





usoc[, .N, .(sclfsat2, x = jbsoc00_cc %ilike% "teach")] |>
    ggplot() +
    geom_col(aes(x = N, y = sclfsat2, fill = x), position = position_dodge())



s <- readRDS("rds/bhps/bb_indresp.Rds")

s %>% head(20)  %>% sie()


usoc[, number_of_waves_present := .N  , by = pidp]
s <- readRDS("rds/bhps/bb_indresp.Rds")
s$bb_indin91_lw


p <- readRDS("rds/ukhls/a_indresp.Rds")

p$a_indinus_xw
p$a_indscus_xw

x <- readRDS("rds/bhps/xwaveid_bh.Rds")


x |> as_factor() |> as.character() |> as.numeric()

usoc[pidp == 68035365]
usoc[pidp == 68058485]
usoc[pidp == 68058489]
usoc[pidp == 68064605]
usoc[pidp == 68064609]
usoc
usoc[wave == "c"]

soc_coding <- data.table::fread(system.file("coding_frames", "soc00.csv", package = "tidyusoc"))

data.table::setnames(soc_coding, c("jbsoc00_cc", "occ"))

soc_coding[, occ := factor(occ)]

df <- merge(df, soc_coding, by = "jbsoc00_cc")








