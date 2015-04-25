# getting_and_cleaning_data
This project contains run_analysis.R script, which reads two data files 'test' and 'train', filters data for mean and standard deviation, groups the data by activity and subject using Smartphones dataset at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Once executed, the resulting dataset maybe found at cleandata.summary.txt

run.analysis() 
1.0 Downloads and processes the required data.
2.0 Labels the columns of data sets accordingly.
3.0 Combines train and test datasets into one complete data set.
4.0 Create a second, independent tidy data set with average of each variable for each activity and each subject.
5.0 Write the tidy_data.txt to a space separated text file.

Required R packages
data.table
reshape2
sqldf
