<<<<<<< HEAD
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


library(ChemmineR)
# looks like this package will not produce a list of molecular descriptors like rcdk did
#trying to get rdk to work with a python script in rstudio 
# will use rcdk for now

#rcdk was updated and is now usable 

#loading in data
data <- read.csv("C:/Users/morsheam/Box/Machine Learning Collaboration/Data_for_model_building/geier_shankar_current_final_iupac_smiles.csv")
data <- data %>%
  select(-X)%>%
  rownames_to_column(var= "row.names")

#reading in chemical structures with ChemmineR
smiles <- read.SMIset("smiles.txt")



mols <- load.molecules(c("PAH_list_shankar_current.mol"))

dc <- get.desc.categories()
dc
dn <- get.desc.names(type="all")
dn
aDesc <- eval.desc(mols, dn[3])
allDescs <- eval.desc(mols, dn) 

fps <- lapply(mols, get.fingerprint, type='circular')
library(fingerprint)
fps_binary <- fp.factor.matrix(fps)





# making a clustering of chemical similarity based on fingerprints

fp.sim <- fingerprint::fp.sim.matrix(fps, method='tanimoto')

fp.dist <- 1 - fp.sim

cls <- hclust(as.dist(fp.dist))
plot(cls, main='A Clustering of the PAH dataset', labels=FALSE)


#HI
# test edit
=======
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


library(ChemmineR)
# looks like this package will not produce a list of molecular descriptors like rcdk did
#trying to get rdk to work with a python script in rstudio 
# will use rcdk for now

#rcdk was updated and is now usable 

#loading in data
data <- read.csv("C:/Users/morsheam/Box/Machine Learning Collaboration/Data_for_model_building/geier_shankar_current_final_iupac_smiles.csv")
data <- data %>%
  select(-X)%>%
  rownames_to_column(var= "row.names")

#reading in chemical structures with ChemmineR
smiles <- read.SMIset("smiles.txt")



mols <- load.molecules(c("PAH_list_shankar_current.mol"))

dc <- get.desc.categories()
dc
dn <- get.desc.names(type="all")
dn
aDesc <- eval.desc(mols, dn[3])
allDescs <- eval.desc(mols, dn) 

fps <- lapply(mols, get.fingerprint, type='circular')
library(fingerprint)
fps_binary <- fp.factor.matrix(fps)





# making a clustering of chemical similarity based on fingerprints

fp.sim <- fingerprint::fp.sim.matrix(fps, method='tanimoto')

fp.dist <- 1 - fp.sim

cls <- hclust(as.dist(fp.dist))
plot(cls, main='A Clustering of the PAH dataset', labels=FALSE)


 
>>>>>>> 3e89bacce94c1ce28666cf3f685010775c4fe627
