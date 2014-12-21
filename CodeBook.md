Description of the variables, data, and any transformations or work performed to clean up the data
------------------------------------------------------------------------------------------------
First define the url address to download the data in the working directory.
Then, several tables contain the data included in the *.txt files included in the folders. These matrix are X_train, y_train, sub_train, X_test, y_test and sub_train.
X_all, y_all and sub_all contain the data including train and test.
Since only data with mean and standard deviation are required, X_mstd contains only that columns.
act reads the file that tell which activity correspond with a number.
y_tot contains that modification for y_all.
data contains the mean and sd data for each subject and for each activity.

Finally tidydata contains the mean of the values in a table written in tidydata.txt
