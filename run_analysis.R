    #This project contains run_analysis.R script, which reads two data files 'test' and 'train', filters data for mean and standard deviation, groups the data by activity and subject using Smartphones dataset at:
    # http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
    #Once executed, the resulting dataset maybe found at cleandata.summary.txt

    if (!require("data.table")) {
      install.packages("data.table")
    }

    if (!require("reshape2")) {
      install.packages("reshape2")
    }
        
    if (!require("sqldf")) {
      install.packages("sqldf")
    }

    require("data.table")
    require("reshape2")
    require("sqldf")

    load.dataset <- function (set, features, activity) {
        # The function loads and train or a test data into data.table     
        # train and test sub-directories are in the current directory getwd() 
        prefix        <- paste(set, '/', sep = '') 
        data.file     <- paste(prefix, 'X_', set, '.txt', sep = '') 
        activity.file <- paste(prefix, 'y_', set, '.txt', sep = '') 
        subject.file  <- paste(prefix, 'subject_', set, '.txt', sep = '') 
  
        data          <- read.table(data.file)[, features$index] 
        names(data)   <- features$name 
        print(paste("X Data loaded for dataset:",set))

        activity.set  <- read.table(activity.file)[, 1] 
        data$label    <- factor(activity.set, levels=activity$serial, labels=activity$label) 
        print(paste("y_data/Activity loaded for dataset:",set))

        subject.set   <- read.table(subject.file)[, 1] 
        data$subject  <- factor(subject.set) 
        print(paste("Subjects loaded for dataset:",set))

        # load data.frame to data.table for cleaner data 
        data.table(data) 
     } 
 
 
     run.analysis <- function () { 
     
         # Read features.txt, filter '-(mean|std)[(]' pattern on name column and subset
         features    <- read.table('features.txt', col.names = c('index', 'name')) 
         features    <- subset(features, grepl('-(mean|std)[(]', features$name)) 
 
         # Read activity_lable.txt and level the column with activity  
         activities <- read.table('activity_labels.txt', col.names = c('serial', 'label'))
 
         # Read train and test data sets 
         train.set <- load.dataset('train', features, activities) 
         test.set <- load.dataset('test', features, activities) 
 
         # Merges the training and the test sets and write to a csv file 
         dataset <- rbind(train.set, test.set) 
         write.csv(dataset, file = 'mergedata.csv', row.names = FALSE) 

         # Extracts only the measurements on the mean and standard deviation for each measurement.
         clean.dataset <- dataset[, lapply(.SD, mean), by=list(label, subject)] 
     
         # Clean the Column Headers
         setnames(clean.dataset, colnames(clean.dataset), gsub("\\(\\)", "", colnames(clean.dataset)))
         setnames(clean.dataset, colnames(clean.dataset), gsub("Acc", "", colnames(clean.dataset))) 
         setnames(clean.dataset, colnames(clean.dataset), gsub("-", "_", colnames(clean.dataset))) 
         setnames(clean.dataset, colnames(clean.dataset), gsub("BodyBody", "Body", colnames(clean.dataset))) 
  
         # write the clean data to a file 
         write.csv(clean.dataset, file = 'cleandata.csv', row.names = FALSE, quote = FALSE)
 	          
         # 5.0 create .... with the average of each variable for each activity and each subject.
         clean.dataset.summary <- sqldf("select * from 'clean.dataset' group by subject,label")       

         # Write clean.dataset to file 
         write.table(clean.dataset.summary, file="cleandata.summary.txt", row.names=FALSE) 

     }
