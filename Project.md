Development of the program in R for prediction
------------------------------------------------
The file run_analysis.R was programmed using R-STUDIO.

The libraries to work with are the following:
library(caret)
library(randomForest)

Cleaning data
-------------------
Two *.csv files were provided. These files are read usin read.csv.
Cleaning data is a need in this case mainly because:
  1. Several #DIV/0 data are shown in the files
  2. Several columns have empty values
  3. The first seven columns do not have information.
We will remove the columns that have any ofthe previous values in the training and testing data.
And those will be the data we will work with to develop the model.

Modelling
-----------
Once we have the data to do the modelling, will train the data.
After several trials, the Random Forest is the model that best fits, because it shows the highest cross validation accuracy.
The classe value will be approached using all the valid values.
model <- train(classe ~ ., data = traindef, method = "rf")

The prediction for the training data is obtained, and so is the confusionmatrix
predictiontrain<-predict(model, traindef)
Finally, the same is calculated for the test data
predictiontest<-predict(model, testdef)
confusionMatrix(predictiontest,testdef$classe)

Conclussions
-------------
Random Forest method provides high accuracy results, to predict the activities from data obtained from acelerometers
