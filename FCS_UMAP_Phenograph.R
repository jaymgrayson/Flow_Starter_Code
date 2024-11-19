#UMAP and Phenograph Script
# Jason M. Grayson

rm(list=ls())
library(tidyverse)
library(splitstackshape)
library(umap)
library(Rphenograph)

setwd("")
#Load your transformed and Scaled RDa
load("")

#Set seed for reproducibility. 
set.seed(1234)
# Hold label data in separate dataframe
Labels<-df[,c(13:26)]
# Extract numeric transformed and scaled data
df<-df[,-c(13:26)]
df<-lapply(df,as.numeric)
df<-as.data.frame(df)
#Run UMAP. Save the model for future projections
umap_output<-umap(df)
umap_coord<-umap_output[[1]]
umap_coord<-as.data.frame(umap_coord)
save(umap_output,file="umap_output.RDa")

# Save UMAP V1 and V2 coordinates
save(umap_coord,file="umap_coord.RDa")
df_scaled_with_label<-cbind(Labels,umap_coord)
#Run phenograph on transformed and scaled FCS data. k higher allws more neigbors to vote!

flow_pheno<-Rphenograph(df,k=85)
phenograph_cluster<-membership(flow_pheno[[2]])
phenograph_cluster<-as.factor(phenograph_cluster)
df_scaled_with_label<-cbind(df_scaled_with_label,phenograph_cluster)
df<-cbind(df,df_scaled_with_label)
save(df,file="df.RDa")
