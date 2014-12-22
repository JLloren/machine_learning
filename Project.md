Development of the program in R for prediction
------------------------------------------------
The file run_analysis.R was programmed using R-STUDIO.

The libraries to work with are the following
library(caret)
library(randomForest)
-------------------
set.seed(12481)
# Introduce the two url adresses for download the data
url_train<-"https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
url_test<-"https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
# Download in the working directory
dir<-getwd()
# Name the files as the owner of the data
download.file(url_train,"pml-training.csv")
download.file(url_test,"pml-testing.csv")
# Read the downloaded files
# There are several data #DIV/0 and empty values, so treat them as NA
# That way, columns containing NA will not be used to predict and train
train<-read.csv("pml-training.csv",na.strings=c("#DIV/0!",""))
test<-read.csv("pml-testing.csv",na.strings=c("#DIV/0!",""))
# The first 7 columns do not provide information and won't be considered
# The last one will be treated as a factor
for (i in 8:ncol(train)-1){
  train[,i]<-as.character(train[,i])
  train[,i]<-as.numeric(train[,i])
  test[,i]<-as.character(test[,i])
  test[,i]<-as.numeric(test[,i])
}
# Rename the data deleting the first 7 columns
train<-train[,8:ncol(train)]
test<-test[,8:ncol(test)]
# Guess which columns contain NA values
ftrain<-is.na(train[,1:ncol(train)])
for (i in 1:ncol(ftrain)){
  ftrain[,i]<-as.numeric(ftrain[,i]) 
} 
# The matrix ftrain contains 1 and 0 if there are NA or not
# Sum columns and if a NA appears, the value is bigger than 0
coltrain<-!colSums(ftrain)>0
# CLEAN data and only work with dat without NA
traindef<-train[,coltrain]
# The same for the test
testdef<-test[,coltrain]

# Create a model with Random Forest model because the cross validation accuracy is bigger
model <- train(classe ~ ., data = traindef, method = "rf")
# Do the prediction with the training data
predictiontrain<-predict(model, traindef)
# Check accuracy with training data
confusionMatrix(predictiontrain,traindef$classe)
# The same for the test
predictiontest<-predict(model, testdef)
confusionMatrix(predictiontest,testdef$classe)
