# Simple Flow Data Visualization
# Jason M. Grayson


rm(list=ls())
library(tidyverse)
library(splitstackshape)
setwd("")
load("")

# We stratify data by variable of interest to amke sure we dont overplot. splitstackshape works well
set.seed(1234)
df2<-stratified(Pan_UMAP_all,c("Relapse","Day_Rounded"), size=500)
df2$Day_Rounded<-factor(df2$Day_Rounded,levels=c("0","15","30","45","60","100","180"))

g1<-ggplot(df2, aes(x=V1,y=V2,color=phenograph_cluster))+geom_point(size=0.1)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+ guides(color = guide_legend(override.aes = list(size=2)))
g1<-g1+facet_grid(vars(Relapse),vars(Day_Rounded))+ggtitle("Pan Immune")
g1

