# Script to transform and scale flow data
# Started by Mildred Perez and Sam Short, edited by Jason Grayson

#Clean up workspace
rm(list = ls())

## Bring in some libraries 
library(flowCore)
library(flowTrans)

#Load your imported and labelled flow data as .RDa or .RDS
load("")

#Re-assign to df to allow easier code manipulation
df<-No_stim_CD4
##ArcSinh transformation using flowTrans package, extract numeric columns (flow data)
ICS_data<- as.matrix(df[,-c(3,15:17)])
ICS_data<- flowFrame(ICS_data)
#Perform transformation, try several of the options if there is a difficulty when converging
ICS_trans <- flowTrans(dat=ICS_data,fun="mclMultivBoxCox",colnames(ICS_data), n2f=FALSE,parameters.only = FALSE)
ICS_after_trans <- exprs(ICS_trans$result)
ICS_after_trans<-as.data.frame(ICS_after_trans)
Labels<-df[,c(15:17)]
CD8_Val_02_after_trans<-cbind(ICS_after_trans,Labels)
##Save the after trans Rda
setwd("")
save(CD8_Val_02_after_trans,file="CD8_Val_02_after_trans.RDa")

#Scale the transofrmed data
CD8_Val_02_after_trans_scaled<-scale(CD8_Val_02_after_trans[,c(1:13)])
CD8_Val_02_after_trans_scaled<-as.data.frame(CD8_Val_02_after_trans_scaled)
CD8_Val_02_after_trans_scaled_with_label<-cbind(CD8_Val_02_after_trans_scaled,Labels)
#Save transformed and scaled data with label
save(CD8_Val_02_after_trans_scaled_with_label,file="CD8_Val_02_after_trans_scaled_with_label.RDa")
