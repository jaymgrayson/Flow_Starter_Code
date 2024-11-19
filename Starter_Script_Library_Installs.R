# Starter script-Library installs
# Jason M. Grayson

#Here are some CRAN installs
#When prompted update all
install.packages("tidyverse")
install.packages("Rtsne")
install.packages("umap")

#Here are the Bioconductor installs
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.20")

BiocManager::install("flowCore")
BiocManager::install("flowTrans")
BiocManager::install("FlowSOM")

install.packages("devtools") 
devtools::install_github("JinmiaoChenLab/Rphenograph")

# Load your libraries to confirm they are installed properly
