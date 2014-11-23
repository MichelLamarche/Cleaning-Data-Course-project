##set working directory and load libraries
setwd("C:/Users/Michel/Documents/R")
library(plyr)
library(data.table)
##load data 
 features<-read.table("C:/Users/Michel/Documents/R/UCI HAR Dataset/features.txt")
 activity<-read.table("C:/Users/Michel/Documents/R/UCI HAR Dataset/activity_labels.txt")
 X_train<-read.table("C:/Users/Michel/Documents/R/UCI HAR Dataset/train/X_train.txt")
 y_train<-read.table("C:/Users/Michel/Documents/R/UCI HAR Dataset/train/y_train.txt")
 subject_train<-read.table("C:/Users/Michel/Documents/R/UCI HAR Dataset/train/subject_train.txt")
 X_test<-read.table("C:/Users/Michel/Documents/R/UCI HAR Dataset/test/X_test.txt")
 y_test<-read.table("C:/Users/Michel/Documents/R/UCI HAR Dataset/test/y_test.txt")
 subject_test<-read.table("C:/Users/Michel/Documents/R/UCI HAR Dataset/test/subject_test.txt")
## combine similar files
 X_total<-rbind(X_train,X_test)
 y_total<-rbind(y_train,y_test)
 subject_total<-rbind(subject_train,subject_test)
##clear no_longer needed partial files
 rm(X_train)
 rm(y_train)
 rm(subject_train)
 rm(X_test)
 rm(y_test)
 rm(subject_test)
##identify  mean ans std mesures in features file 
 choose<-grepl(pattern ="mean\\(\\)|std\\(\\)",features$V2 )
## create a new data frame from selected columns
 X_clean<-X_total[,choose]
## select mean and std names from the features file and apply to dataset
 choosenames<-(subset(features, choose[]))
 colnames(X_clean)<-choosenames$V2
#add the actitity names and subject to the data frame
y_activity<-join(y_total,activity,by="V1",type = "inner")
X_clean$activity<-cbind(y_activity$V2)
X_clean$subject<-cbind(subject_total$V1)
# rename column for futur join
colnames(activity)[2]<-"activity"
#perform calculations according to double key
tidy_output<- aggregate(X_clean, by=list(X_clean$activity,X_clean$subject),FUN=mean)
# paste activity names
tidy_output$Group.1[tidy_output$activity == 1] <- "WALKING"
tidy_output$Group.1[tidy_output$activity == 2] <- "WALKING_UPSTAIRS"
tidy_output$Group.1[tidy_output$activity == 3] <- "WALKING_DOWNSTAIRS"
tidy_output$Group.1[tidy_output$activity == 4] <- "SITTING"
tidy_output$Group.1[tidy_output$activity == 5] <- "STANDING"
tidy_output$Group.1[tidy_output$activity == 6] <- "LAYING"
# remove unnecessary columns and rename  
tidy_output$activity<- NULL
tidy_output$subject<- NULL
colnames(tidy_output)[1]<-"activity"
colnames(tidy_output)[2]<-"subject"
write.table(tidy_output, file="tidy_output.txt", row.names=FALSE)



