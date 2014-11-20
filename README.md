Getting-and-Cleaning-Data-Project
=================================
I used read.csv to read all the CSV files into R.

The following commands were used to name the fields of the tables.
namesoffeatures <- features$V2
names(X_train) <- namesoffeatures
names(X_test) <- namesoffeatures
names(subject_test) <- "member_ID"
names(y_test) <-"Activity_ID"
names(y_train) <- "Activity_ID"

Then I used cbind to combine the test subjects and train subjects to the test and train data respectively.
Then I used rbind to combine the test and train data into one dataset.
X_test1 <- cbind(subject_test,y_test,X_test)
names(subject_train) <- "member_ID"
X_train1 <- cbind(subject_train,y_train,X_train)
X_combine <- rbind(X_test1,X_train1)

Then I used tbl_df to create the table so I can use to do group_by.
I melted the data and then use grepl to select the mean and std observations only
then I join the activity table and labels.
X_combine_table <- tbl_df(X_combine)
X_combine_1 <- melt(X_combine,id=c("member_ID","Activity_ID"))
X_combine_1_mean <- X_combine_1[grepl("mean()",X_combine_1$variable),]
X_combine_1_std <- X_combine_1[grepl("std()",X_combine_1$variable),]
X_combine_1_mean1 <- merge(X_combine_1_mean, activity_labels, by.x="Activity_ID", by.y="Activity_ID", all=TRUE)
X_combine_1_std1 <- merge(X_combine_1_std, activity_labels, by.x="Activity_ID", by.y="Activity_ID", all=TRUE)

Then I create table using group_by function so I can use it to group by member_id and activity_id
and then I use a write.table to dump the data into .txt files so I can upload to the coursera webset.

X_combine_mean1_tbl <- group_by(X_combine_1_mean1,member_ID,Activity_ID)
X_combine_std1_tbl <- group_by(X_combine_1_std1,member_ID,Activity_ID)

X_combine_mean1_sum <- summarize(X_combine_mean1_tbl,mean(value))
X_combine_std1_sum <- summarize(X_combine_std1_tbl,mean(value))

X_combine_mean1_sum <- merge(X_combine_mean1_sum, activity_labels, by.x="Activity_ID", by.y="Activity_ID", all=TRUE)
X_combine_std1_sum <- merge(X_combine_std1_sum, activity_labels, by.x="Activity_ID", by.y="Activity_ID", all=TRUE)

write.table(X_combine_mean1_sum,file='C:/Users/shua/Documents/R_data/mean.csv',sep=",", row.names=FALSE)
write.table(X_combine_std1_sum,file='C:/Users/shua/Documents/R_data/std.csv',sep=",", row.names=FALSE)

Getting and Cleaning Data Project
