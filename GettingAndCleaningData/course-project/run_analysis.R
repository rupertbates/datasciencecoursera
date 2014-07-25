# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


#Load in the lists of features and activities
features <- read.table("./course-project/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
featureNames <- features[,2]
activityNames <- read.table("./course-project/UCI HAR Dataset/activity_labels.txt", col.names=c("activityId", "activity"))

# Get a full list of names for the measurement columns and also a list of columns which contain mean and standard deviation measurements
regex <- "^.*mean().*|^.*std().*"
meanStdCols <- grep(regex, featureNames, value=TRUE)

# The list of columns in the tidied dataframe
colNames <- c(c("subject", "activity"), gsub(gsub(meanStdCols, pattern="-", replacement="."), pattern="\\(|\\)", replacement=""))


loadAndTidyDataset <- function(x){
  # Load the full data set
  data <- read.table(paste0("./course-project/UCI HAR Dataset/", x, "/X_", x, ".txt"), col.names=featureNames)
  
  # Reduce the data frame to just those columns containing mean and standard deviation measurements
  data <- data[grep(regex, names(data), value=TRUE)]
  
  # Add the subject and activity into the dataset
  subject <- read.table(paste0("./course-project//UCI HAR Dataset/", x, "/subject_", x, ".txt"), col.names=c("subject"))
  activity <- read.table(paste0("./course-project/UCI HAR Dataset/", x, "/y_", x, ".txt"), col.names=c("activityId"))
  
  sAndA <- data.frame(subject, activity)
  sAndAMerged <- merge(x=sAndA, y=activityNames, by="activityId")
  
  data <- data.frame(sAndAMerged$subject, sAndAMerged$activity, data)
  
  # Add descriptive names to the columns
  names(data) <- colNames
  data 
}


test <- loadAndTidyDataset("test")
train <- loadAndTidyDataset("train")

# Merge the datasets
merged <- rbind(test, train)

# Create a second, independent tidy data set with the average of each variable for each activity and each subject
library(reshape2)

df_melt <- melt(merged, id = c("subject", "activity"))
df_cast <- dcast(df_melt, subject + activity ~ ..., mean)

#summed <-aggregate(merged$tBodyAcc.mean...X ~ merged$subject + merged$activity, FUN=mean, na.rm=TRUE)




