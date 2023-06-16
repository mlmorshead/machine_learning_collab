library(tidyverse)

interact_list_raw <- read.csv("C:/Users/morsheam/Box/Machine Learning Collaboration/Protein lists/ctdbase_interaction_export_all_cyclic.csv")

chemical_data <- read.csv("C:/Users/morsheam/Box/Mackenzie/Oregon State Documents/Tanguay Lab/PAHs/compound lists/geier_shankar_current_final.xlsx")


interact_list <- interact_list_raw %>%
  filter(CAS.RN %in% chemical_data$casrn, grepl('binds to', Interaction), !grepl('AHR protein binds to', Interaction))


gene_num_pubs <- as.data.frame(table(interact_list$Gene.Symbol, interact_list$Chemical.Name))
gene_num_pubs <- gene_num_pubs %>%
  filter(Freq!=0)
colnames(gene_num_pubs) <- c("Gene.Symbol", "chemical.name", "publications")

grouped_gene_num_pubs <- gene_num_pubs %>%
  group_by(Gene.Symbol)

sum_pubs <- grouped_gene_num_pubs %>% summarise(sum(publications))


gene_num_chem <- as.data.frame(table(gene_num_chem$Gene.Symbol))
colnames(gene_num_chem)<- c("Gene.Symbol", "num_chems")

gene_chem_pubs <- sum_pubs %>%
  inner_join(gene_num_chem, by ="Gene.Symbol")



