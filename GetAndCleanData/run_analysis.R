run_analysis <- function() {
        
        ## Set working directory
        setwd("~/Debra Bowen Data Science")
        
        ## Read X_test.txt into table test
        ## This is the table of measurements for test
        test <- read.table("C:\\Users\\Debra\\Documents\\Debra Bowen Data Science\\Course 3 Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\test\\X_test.txt", 
                                header = FALSE)
        
        ## Read X_train.txt into table train
        ## This is the table of measurements for train
        train <- read.table("C:\\Users\\Debra\\Documents\\Debra Bowen Data Science\\Course 3 Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\train\\X_train.txt", 
                                header = FALSE)

        ## Read y_test.txt into table testactivity
        ## This is the activity column for test
        testactivity <- read.table("C:\\Users\\Debra\\Documents\\Debra Bowen Data Science\\Course 3 Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\test\\y_test.txt", 
                                header = FALSE)

        ## Read y_train.txt into table trainactivity
        ## This is the activity column for train
        trainactivity <- read.table("C:\\Users\\Debra\\Documents\\Debra Bowen Data Science\\Course 3 Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\train\\y_train.txt", 
                                header = FALSE)
 
        ## Read subject_test.txt into table testsubject
        ## This is the subject column for test
        testsubject <- read.table("C:\\Users\\Debra\\Documents\\Debra Bowen Data Science\\Course 3 Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\test\\subject_test.txt", 
                                header = FALSE)
        
        ## Read subject_train.txt into table trainsubject
        ## This is the subject column for train
        trainsubject <- read.table("C:\\Users\\Debra\\Documents\\Debra Bowen Data Science\\Course 3 Getting and Cleaning Data\\Course Project\\UCI HAR Dataset\\train\\subject_train.txt", 
                                header = FALSE)
        
        ## Read measurements.csv into table measurements
        ## These are column headings for data
        measurements <- read.csv("C:\\Users\\Debra\\Documents\\Debra Bowen Data Science\\measurements.csv", 
                                header = FALSE, stringsAsFactors = FALSE)

        ## measurements col names
        names(measurements) <- c("colid", "accelname")
        
        ## testsubject col name
        names(testsubject) <- "subject"
        
        ## trainsubject col name
        names(trainsubject) <- "subject"
        
        ## convert activity numbers to text
        testactivity <- within(testactivity,V1[V1==1] <- "walk")
        testactivity <- within(testactivity,V1[V1==2] <- "walkupstairs")
        testactivity <- within(testactivity,V1[V1==3] <- "walkdownstairs")
        testactivity <- within(testactivity,V1[V1==4] <- "sit")
        testactivity <- within(testactivity,V1[V1==5] <- "stand")
        testactivity <- within(testactivity,V1[V1==6] <- "lay")
        trainactivity <- within(trainactivity,V1[V1==1] <- "walk")
        trainactivity <- within(trainactivity,V1[V1==2] <- "walkupstairs")
        trainactivity <- within(trainactivity,V1[V1==3] <- "walkdownstairs")
        trainactivity <- within(trainactivity,V1[V1==4] <- "sit")
        trainactivity <- within(trainactivity,V1[V1==5] <- "stand")
        trainactivity <- within(trainactivity,V1[V1==6] <- "lay")
        
        ## combine activity and subject with test, 
        ## placing subject into 1st column
        test <- cbind(testactivity$V1, test)
        test <- cbind(testsubject[,1], test)
        
        ## combine activity and subject with train, 
        ## placing subject into 1st column
        train <- cbind(trainactivity$V1, train)
        train <- cbind(trainsubject[,1], train)
        
        # rename 1st and 2nd column in test
        colnames(test)[1] <- "subject"
        colnames(test)[2] <- "activity"
        
        # rename 1st and 2nd column in train
        colnames(train)[1] <- "subject"
        colnames(train)[2] <- "activity"
        
        ## create a vector with measurement column names
        namesvector <- measurements$accelname
        
        ## recreate namesvector with "subject" as 1st column
        ## and "activity" as 2nd column
        namesvector <- append("activity", namesvector, after = 1)
        namesvector <- append("subject", namesvector, after = 1)
        
        ## merge test and train data
        testtrain <- merge(test, train, all = TRUE)
        
        ## assign measurement col names to merged data
        names(testtrain) <- namesvector
        
        ## create data frames with std dev and mean columns,
        ## subject and activity
        v <- testtrain[,grepl("std", colnames(testtrain))]
        w <- testtrain[,grepl("Mean", colnames(testtrain))]
        x <- testtrain[,grepl("mean", colnames(testtrain))]
        y <- testtrain[,grepl("subject", colnames(testtrain))]
        z <- testtrain[,grepl("activity", colnames(testtrain))]
        
        ## change "subject" column to numeric
        y <- as.character(y)
        y <- data.frame(y, stringsAsFactors = FALSE)
        names(y) <- "subject"
        y$subject <- as.numeric(y$subject)
        
        ## change "activity" column to character
        z <- as.character(z)
        z <- data.frame(z, stringsAsFactors = FALSE)
        names(z) <- "activity"
        
        ## create dataframe with activity, mean and std dev columns
        accel <- cbind(v, w)
        accel <- cbind(accel, x)
        accel <- cbind(y, accel)
        accel <- cbind(z, accel)
        
        ## change data column names to lower case
        names(accel) <- tolower(names(accel))
        
        ## remove from column names:
        ## ()
        ## -
        ## (
        ## (
        ## ,
        names(accel) <- sub("\\()","",names(accel))
        names(accel) <- gsub("-","",names(accel))
        names(accel) <- gsub("\\(","",names(accel))
        names(accel) <- gsub(")","",names(accel))
        names(accel) <- gsub(",","",names(accel))
        
        # sort by activity, subject:
        accelsort <- accel[order(accel$activity, accel$subject),]
        
        ## Create an independent tidy data set with the mean of each 
        ## variable:
        accelmean <- aggregate(accelsort[,3:88], 
                        list(accelsort$subject, accelsort$activity), mean)
        
        ## rename 1st and 2nd columns
        colnames(accelmean)[1] <- "subject"
        colnames(accelmean)[2] <- "activity"
        
        return(accelmean)
}