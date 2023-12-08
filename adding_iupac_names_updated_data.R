library(tidyverse)
library(readxl)

"%notin%" <- Negate("%in%")
updated <- read.csv("C:/Users/morsheam/Box/Mackenzie/Oregon State Documents/Tanguay Lab/PAHs/compound lists/geier_shankar_current_final.csv")

iupac_names <-read_excel("C:/Users/morsheam/Box/Mackenzie/Oregon State Documents/Tanguay Lab/PAHs/compound lists/shaker_geier_current.xlsx")
duplicated(iupac_names$chemical.name)

iupac_names_dups_removed <- iupac_names%>%
  group_by(chemical.name)%>%
  slice(which.max(!is.na(iupac.name)))



missing_iupac <- updated%>%
  filter(chemical.name%notin%iupac_names$chemical.name)
missing_updated <- iupac_names%>%
  filter(chemical.name%notin%updated$chemical.name)


updated_w_iupac <- updated %>%
  left_join(select(iupac_names_dups_removed, iupac.name, chemical.name), by="chemical.name")



write.csv(updated_w_iupac, "C:/Users/morsheam/Box/Mackenzie/Oregon State Documents/Tanguay Lab/PAHs/compound lists/geier_shankar_current_final.csv")
