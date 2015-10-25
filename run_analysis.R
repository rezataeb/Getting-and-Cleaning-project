library(dplyr) 

x.test <- read.table("./test/X_test.txt")
y.test <- read.table("./test/y_test.txt")
sub.test <- read.table("./subject_test.txt")

x.train <- read.table("./train/X_train.txt")
y.train <- read.table("./train/y_train.txt")
sub.train <- read.table ("./train/subject_train")


x.data <- rbind(x.test,x.train)
y.data <- rbind(y.test,y.train)
sub.data <- rbind(sub.test,sub.train)

fea<- read.table("features.txt")
act.lab <- read.table("activity_labels.txt")


mean.std.features <- grep("-(mean|std)\\(\\)", fea[,2])
x.data.desire <- x.data[,mean.std.features] 
y.data.desire <- y.data[,mean.std.features]  ###

names(x.data.desire) <- fea[mean.std.features, 2] 
names(y.data.desire) <- fea[mean.std.features, 2]  ###

y.data[, 1] <- act.lab[y.data[, 1], 2]
names(y.data) <- "activity"
names(sub.data) <- "subject"

all.data <- cbind(x.data.desire,y.data,sub.data)

average.data <- ddply(all.data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(average.data, "averages_data.txt", row.name=FALSE)