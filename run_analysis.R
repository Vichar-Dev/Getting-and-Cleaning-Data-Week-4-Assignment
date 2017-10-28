library(reshape2)

runAnalysis <- function(){
  
  unzipFolder <- "UCI HAR Dataset"
  downloadFile <- "FUCI_HAR_Dataset.zip"
  downloadLink <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  ## Check if dataset folder has already been unzipped
  if(!file.exists(unzipFolder)){
    
    ## Check if file has already been downloaded
    if (!file.exists(downloadFile)){
      
      ## File not downloaded, hence download file
      download.file(downloadLink, downloadFile)
      
    } else {
      ## File already downloaded
    }
    
    ## now Unzip file and extract dataset
    unzip(downloadFile)
    
  } else {
    ## Dataset folder exist already
  }
  
  ## read all data
  activity_labels <- read.table(paste0("./",unzipFolder,"/activity_labels.txt"))[,2]
  
  features <- read.table(paste0("./",unzipFolder,"/features.txt"))
  
  subject_test <- read.table(paste0("./",unzipFolder,"/test/subject_test.txt"))
  x_test <- read.table(paste0("./",unzipFolder,"/test/X_test.txt"))
  y_test <- read.table(paste0("./",unzipFolder,"/test/y_test.txt"))

  subject_train <- read.table(paste0("./",unzipFolder,"/train/subject_train.txt"))
  x_train <- read.table(paste0("./",unzipFolder,"/train/X_train.txt"))
  y_train <- read.table(paste0("./",unzipFolder,"/train/y_train.txt"))

  ## append all data
  subjects <- rbind(subject_test, subject_train)
  samples <- rbind(x_test, x_train)
  activities <- rbind(y_test, y_train)
  
  ## replacing activity code with activity name
  activities[,2]<-activity_labels[activities[,1]]
  activities<-activities[,2]
  activities<-as.data.frame(activities)
  
  ## extract only the data on mean and standard deviation
  featuresWanted <- grep("mean|std", features[,2])
  samples <- samples[,featuresWanted]
  
  ## tidy the column names
  featuresWanted.names <- features[featuresWanted,2]
  featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
  featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
  featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)
  
  ## combine all data
  allData <- cbind(subjects, activities, samples )
  colnames(allData) <- c("subject", "activity", featuresWanted.names)
  
  ## grouped mean for each subject based on activity
  allData.melted <- melt(allData, id = c("subject", "activity"))
  allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)
  
  ## write the data into file
  write.table(allData.mean, "tidy.txt",row.names = FALSE)
}

