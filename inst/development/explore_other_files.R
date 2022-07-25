


job1 <- read_sav("spss/spss25/ukhls/a_empstat.sav") # Occupation
job2 <- read_sav("spss/spss25/ukhls/e_empstat.sav") # Occupation



income1 <- read_sav("spss/spss25/ukhls/a_income.sav") # Income
income2 <- read_sav("spss/spss25/ukhls/b_income.sav") # Income
income3 <- read_sav("spss/spss25/ukhls/c_income.sav") # Income
income4 <- read_sav("spss/spss25/ukhls/d_income.sav") # Income
income5 <- read_sav("spss/spss25/ukhls/e_income.sav") # Income
income6 <- read_sav("spss/spss25/ukhls/f_income.sav") # Income
income7 <- read_sav("spss/spss25/ukhls/g_income.sav") # Income
income8 <- read_sav("spss/spss25/ukhls/h_income.sav") # Income
income9 <- read_sav("spss/spss25/ukhls/i_income.sav") # Income
income10 <- read_sav("spss/spss25/ukhls/j_income.sav") # Income
income11 <- read_sav("spss/spss25/ukhls/k_income.sav") # Income


income1 %>%
  tidylog::inner_join(income2, on = "pidp") %>%
  tidylog::inner_join(income3, on = "pidp") %>%
  tidylog::inner_join(income4, on = "pidp") %>%
  tidylog::inner_join(income5, on = "pidp") %>%
  tidylog::inner_join(income6, on = "pidp") %>%
  tidylog::inner_join(income7, on = "pidp") %>%
  tidylog::inner_join(income8, on = "pidp") %>%
  tidylog::inner_join(income9, on = "pidp") %>%
  tidylog::inner_join(income10, on = "pidp") %>%
  tidylog::inner_join(income11, on = "pidp")

      
income1 %>%
  count(pidp)

income1 %>%
  filter(pidp ==  68006127) %>%
  sie()



job <- read_sav("spss/spss25/ukhls/a_empstat.sav") # Occupation
income <- read_sav("spss/spss25/ukhls/a_income.sav") # Income
df <- read_sav("spss/spss25/ukhls/a_indresp.sav")  
df <- read_sav("spss/spss25/ukhls/a_adopt.sav") # Adoption
df <- read_sav("spss/spss25/ukhls/a_callrec.sav") # Call record
df <- read_sav("spss/spss25/ukhls/a_child.sav") # Children?
df <- read_sav("spss/spss25/ukhls/a_cohab.sav") # Cohabitation
df <- read_sav("spss/spss25/ukhls/a_hhresp.sav") # household structure, people, dishwasher,
df <- read_sav("spss/spss25/ukhls/a_hhsamp.sav")# Languages spoken, floors, car
df <- read_sav("spss/spss25/ukhls/a_indall.sav") # Mother father age language sex
df <- read_sav("spss/spss25/ukhls/a_issue.sav") # Household identifies and year
df <- read_sav("spss/spss25/ukhls/a_marriage.sav")
df <- read_sav("spss/spss25/ukhls/a_natchild.sav") # Natural children
df <- read_sav("spss/spss25/ukhls/a_youth.sav") # Kids and conduct problems
df <- read_sav("spss/spss25/ukhls/a_egoalt.sav") # Relationships
