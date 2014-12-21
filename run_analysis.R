# First, we need to know where the *.zip file will be downloaded
# Suppose the user has defined the working directory
getwd()
dir<-getwd()
# Our folder in *.zip format will be called datos.zip
fzip<-paste(dir,"datos.zip",sep="/")
# Introduce the url of the data to be downloaded
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# Download the data as fzip
download.file(url,fzip)
# Unzip the file, and create a new folder
unzip(fzip)
folder<-paste(dir,"UCI HAR Dataset",sep="/")
# Now I get the data required. 

### STEP 1 ###
# First, the train folder
y_train <- read.table(paste(folder,"train/y_train.txt",sep="/"))
X_train <- read.table(paste(folder,"train/X_train.txt",sep="/"))
sub_train<-read.table(paste(folder,"train/subject_train.txt",sep="/"))
# Then the test folder
y_test <- read.table(paste(folder,"test/y_test.txt",sep="/"))
X_test <- read.table(paste(folder,"test/X_test.txt",sep="/"))
sub_test<-read.table(paste(folder,"test/subject_test.txt",sep="/"))
# Merge the subject data for both train and test
sub_all<-rbind(sub_train,sub_test)
names(sub_all)<-"Subject"
# The names for the columns in X files are contained in a file "features.txt"
X_names<-read.table(paste(folder,"features.txt",sep="/"))
# Merge the X data 
X_all<-rbind(X_train,X_test)
# Assign the names for columns
names(X_all)<-X_names[,2]

### STEP 2 ###
# Get only the columns that contain mean of standard deviation values
mstd<-grep("(mean|std)\\(\\)",names(X_all))
X_mstd<-X_all[,mstd]

# Finally, merge the data for Y files
y_all<-rbind(y_train,y_test)
# Get the corresponding activity according to the number
act<-read.table(paste(folder,"activity_labels.txt",sep="/"))
# Create an auxiliary table

### STEP 3 ###
y_tot<-y_all
# Assign the activity to the number
for (i in 1:nrow(y_all)){
  y_tot[i,1]<-as.character(act[y_all[i,1],2])
}
# Name the column as Activity
names(y_tot)<-"Activity"


### STEP 4 ###
# Change the names to make the more easy to understand
names(X_mstd)<-gsub("-mean\\(\\)","_Mean",names(X_mstd))
names(X_mstd)<-gsub("-std\\(\\)","_StandardDeviation",names(X_mstd))
names(X_mstd)<-gsub("^t","Time_",names(X_mstd))
names(X_mstd)<-gsub("^f","Frequency_",names(X_mstd))
names(X_mstd)<-gsub("-","_",names(X_mstd))
names(X_mstd)
# Data contains all the data required

# TIDY DATA REQUIRED IN STEP 4
data<-cbind(sub_all,y_tot,X_mstd)

### STEP 5 ###
library(plyr)
# Create a function that will calculate the mean values of columns
media<-function(datos){
  n<-ncol(datos)
  colMeans(datos[3:n])
}
# With ddply, create the table required
# TIDY DATA REQUIRED IN STEP 5
tidydata<-ddply(.data=data,c("Subject","Activity"),media)
# Write the file
write.table(tidydata, "tidydata.txt", row.names = FALSE)
