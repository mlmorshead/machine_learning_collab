##### Fitting a lasso penalized logistic regression model to predict simple morph_hits
# use cdk descriptors
# use morgan fingerprints
#try both?

#https://www.bioconductor.org/packages/devel/bioc/vignettes/ChemmineR/inst/doc/ChemmineR.html#OpenBabel_Functions
setwd("C:/Users/morsheam/Box/Machine Learning Collaboration/Data_for_model_building/")

library(tidyverse)
library(readxl)
library(rcdk)
library(rJava)
library(dplyr)
library(pROC)
library(class)
library(glmnet) #Warning message: package ‘glmnet’ was built under R version 4.2.3 

#appears rcdk is no longer supported and was removed from CRAN
#using new cheminformatics package for R

if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install("ChemmineR")

library(ChemmineR)
vignette("ChemmineR")

#loading in data
data <- read.csv("C:/Users/morsheam/Box/Machine Learning Collaboration/Data_for_model_building/geier_shankar_current_final_iupac_smiles.csv")
data <- data %>%
  select(-X)%>%
  rownames_to_column(var= "row.names")

#reading in chemical structures with ChemmineR
smiles <- read.SMIset("smiles.txt")
