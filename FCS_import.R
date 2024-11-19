# Starting R Code for ICS files import and conversion to RDa

# Clean prior workspace
rm(list = ls())

# Set your working directory (where fcs files are !)
setwd("")

# Import some key flow libraries
library(flowCore)




# List all files from the current directory.Use the pattern argument to define a common pattern  for import files with regex. Here: .fcs
list.files(pattern=".fcs$")

# Create a label file with data 
Label <- read.csv("Label.csv")

# Take out nonessential information (x should be these columns in csv)
Label<-Label[,-c(x)]

# Make a list of fcs file names
list.filenames <- list.files(pattern=".fcs$")
print(list.filenames)

# Create an empty list that will serve as a container to receive the incoming files
list.data<-list()

# Create a loop to read in your data
for (i in 1:length(list.filenames))
{
    list.data[[i]]<-read.FCS(list.filenames[[i]],transformation = FALSE,truncate_max_range = FALSE)
    
    list.data[[i]]<-as.data.frame(exprs(list.data[[i]]))
    
# Take out variables that do not change (we remove FSC,SSC,Time, CD45(if gated on) here)
# x should be the columns in your fcs you do not need
        list.data[[i]] <- list.data[[i]][,-c(x)]
    
    
# Remove saturated values (defined manually, X-20 Fortessa default 200,000)
    RM <- 
        
        (list.data[[i]][,1] > 200000)|
        
        (list.data[[i]][,2]> 200000)|
        
        (list.data[[i]][,3]> 200000)|
        
        (list.data[[i]][,4]> 200000)|
        
        (list.data[[i]][,5]> 200000)|
        
        (list.data[[i]][,6]> 200000)|
        
        (list.data[[i]][,7]> 200000)|
        
        (list.data[[i]][,8]> 200000)|
        
        (list.data[[i]][,9]> 200000)|
        
        (list.data[[i]][,10]> 200000)|
        
        (list.data[[i]][,11]> 200000)|
        
        (list.data[[i]][,12]> 200000)|
        
        (list.data[[i]][,13]> 200000)|
        
        (list.data[[i]][,14]> 200000)|

        (list.data[[i]][,15]> 200000)
    
    list.data[[i]]<-list.data[[i]][!RM,]
    
# Add labels to each cell ( I have just kept those we use as an example)
    list.data[[i]] <- cbind(list.data[[i]], MRN = rep(Label$MRN[i],nrow(list.data[[i]])), aGVHD = rep(Label$aGVHD[i],nrow(list.data[[i]])),DPT=rep(Label$DPT[i],nrow(list.data[[i]])),Exp_Date=rep(Label$Exp.Date[i],nrow(list.data[[i]])))
}  

# Convert the list to a dataframe
ICS_VAL_with_label <- NULL
for (i in 1:length(list.filenames))
{
    ICS_VAL_with_label <- rbind(ICS_VAL_with_label,list.data[[i]])
}

#Change column names from flourophores to Antigens, also name variable columns ( I have kept some from BMT experiments)
colnames(ICS_VAL_with_label) <- c("IL-9", "IL-17", "CD8a","CD4","IL-2","GzB","TNFa","Tbet","IL-4","IL-10","CD45RA","HLA_DR","IFNg","FoxP3","CD127","MRN","aGVHD","DPT","Exp_Date")

# Save the data
save(ICS_VAL_with_label ,file="ICS_VAL_with_label.Rda")
    
