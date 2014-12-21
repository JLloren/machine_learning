Human Activit Recognition using Smartphones
===================

The script developed accomplishes the objective required.
You can find in the file run_analysis.R a description of the steps taken to get the final results which are included in the file tidydata.txt

First, the *.zip file was downloaded into the working directory, and was unzipped
There are two folders containing train and test data
The structure of these folders is the same, and have a file starting by X, that contains the measured data, a file starting by y, that contains the activity that the subject (another file) is doing.
Then, using read.table get the data in matrix for each of the files x, y and sub; and for each of the folders, train and test
Using rbind join the matrix in train and test
I extract for X data only the files containing mean and standard deviation values
Using cbind join the matrix for x, y and sub
After this, change the names to other that explain a little bit better the measurements

Finally, using library (plyr) create a table with tidy mean data for subjects and activities
This table is the above mentioned tidydata.txt


