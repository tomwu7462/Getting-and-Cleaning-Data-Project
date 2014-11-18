Getting-and-Cleaning-Data-Project
=================================
namesoffeatures <- features$V2
names(X_train) <- namesoffeatures
names(X_test) <- namesoffeatures
names(subject_test) <- "member_ID"
names(y_test) <-"Activity_ID"
names(y_train) <- "Activity_ID"
X_test1 <- cbind(subject_test,y_test,X_test)
names(subject_train) <- "member_ID"
X_train1 <- cbind(subject_train,y_train,X_train)

X_combine <- rbind(X_test1,X_train1)
X_combine_table <- tbl_df(X_combine)
X_combine_1 <- melt(X_combine,id=c("member_ID","Activity_ID"))
X_combine_1_mean <- X_combine_1[grepl("mean()",X_combine_1$variable),]
X_combine_1_std <- X_combine_1[grepl("std()",X_combine_1$variable),]
X_combine_1_mean1 <- merge(X_combine_1_mean, activity_labels, by.x="Activity_ID", by.y="Activity_ID", all=TRUE)
X_combine_1_std1 <- merge(X_combine_1_std, activity_labels, by.x="Activity_ID", by.y="Activity_ID", all=TRUE)

X_combine_mean1_tbl <- group_by(X_combine_1_mean1,member_ID,Activity_ID)
X_combine_std1_tbl <- group_by(X_combine_1_std1,member_ID,Activity_ID)

X_combine_mean1_sum <- summarize(X_combine_mean1_tbl,mean(value))
X_combine_std1_sum <- summarize(X_combine_std1_tbl,mean(value))

X_combine_mean1_sum <- merge(X_combine_mean1_sum, activity_labels, by.x="Activity_ID", by.y="Activity_ID", all=TRUE)
X_combine_std1_sum <- merge(X_combine_std1_sum, activity_labels, by.x="Activity_ID", by.y="Activity_ID", all=TRUE)

write.table(X_combine_mean1_sum,file='C:/Users/shua/Documents/R_data/mean.csv',sep=",", row.names=FALSE)
write.table(X_combine_std1_sum,file='C:/Users/shua/Documents/R_data/std.csv',sep=",", row.names=FALSE)

Getting and Cleaning Data Project
