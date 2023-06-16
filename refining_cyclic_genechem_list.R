library(tidyverse)

interact_list_raw <- read.csv("C:/Users/morsheam/Box/Machine Learning Collaboration/Protein lists/ctdbase_interaction_export_all_cyclic.csv")

chemical_data <- read.csv("C:/Users/morsheam/Box/Mackenzie/Oregon State Documents/Tanguay Lab/PAHs/compound lists/geier_shankar_current_final.xlsx")


interact_list <- interact_list_raw %>%
  filter(CAS.RN %in% chemical_data$casrn, grepl('binds to', Interaction), !grepl('AHR protein binds to', Interaction))


gene_num_chem <- as.data.frame(table(interact_list$Gene.Symbol, interact_list$Chemical.Name))
gene_num_chem <- gene_num_chem %>%
  filter(Freq!=0)
colnames(gene_num_chem) <- c("Gene.Symbol", "chemical.name", "publications")

test <- as.data.frame(table(gene_num_chem$Gene.Symbol))
colnames(test)<- c("Gene.Symbol", "freq")
test2 <- test %>%
  right_join(gene_num_chem, by="Gene.Symbol")%>%
  group_by(Gene.Symbol)%>%
  summarise(sum(publications))


