callFunToMerge <- function()
{
  # read the test files for subject, measurement data (X) and activity ids (Y)
  subject_testfile <- read.table("./test/subject_test.txt",header=FALSE)
  X_testfile <- read.table("./test/X_test.txt",header=FALSE)
  Y_testfile <- read.table("./test/Y_test.txt",header=FALSE)
  # set the columnName of activity file to "ActivityId"
  names(Y_testfile)[1] = "ActivityId"
  
  # set the columnName of subject file to "SubjectId"
  
  names(subject_testfile)[1] = "SubjectId"
  
  # reading the features file
  
  features <- read.table("./features.txt",header=FALSE)
  
  # filtering the features to the interested measurements of mean and standard deviation
  
  interested_features <- features[grepl("mean|std",features$V2),]
  
  # setting the names of data file with the feature names
  
  names(X_testfile) = features$V2
  
  # limiting the data file to only the features interested columns
  
  limitedX_testfile = X_testfile[,interested_features$V2] 
  
  # merging data, subjectid and activity id data together
  
  mergetestdata <- cbind(subject_testfile,limitedX_testfile,Y_testfile)
  
  
  # similar above steps repating for the train files
  
  subject_trainfile <- read.table("./train/subject_train.txt",header=FALSE)
  X_trainfile <- read.table("./train/X_train.txt",header=FALSE)
  Y_trainfile <- read.table("./train/Y_train.txt",header=FALSE)
  names(Y_trainfile)[1] = "ActivityId"
  names(subject_trainfile)[1] = "SubjectId"
  
  names(X_trainfile) = features$V2
  
  mergeddatasetX_trainfile = X_trainfile[,interested_features$V2] 
  
  mergetraindata <- cbind(subject_trainfile,mergeddatasetX_trainfile,Y_trainfile)
  
  # now we have both the test and train data files. Now Merging the training and the test sets to create one data set
  
  mergeddataset <- rbind(mergetestdata,mergetraindata)
  
  # replace the Activity Ids with the Activity Names to use descriptive names in the data set
  
  mergeddataset$ActivityId <- factor(mergeddataset$ActivityId, labels=c("Walking",
                                                                        "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))
  
  # renaming the names to understandable naming convention
  
  names(mergeddataset) <- gsub("ActivityId", "Activity", names(mergeddataset))
  
  names(mergeddataset) <- gsub("^t", "Time", names(mergeddataset))
  names(mergeddataset) <- gsub("^f", "Frequency", names(mergeddataset))
  names(mergeddataset) <- gsub("-", "", names(mergeddataset))
    
  mergeddataset
}

refinedataset <- function(name = "tidy.txt")
{
  mergeddataset <- callFunToMerge()
  
  # creating a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  library(reshape2)
  
  id_labels   = c("SubjectId","Activity")
  
  data_labels = setdiff(colnames(mergeddataset), id_labels)
  
  melt_data      = melt(mergeddataset, id = id_labels, measure.vars = data_labels)
  
  tidy_data   = dcast(melt_data, SubjectId + Activity ~ variable, mean)
  
  write.table(tidy_data, file = paste0("./",name),row.name=FALSE)
  
}