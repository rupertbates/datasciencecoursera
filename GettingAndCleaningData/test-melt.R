df <- data.frame(subject = c(1,1,1,1,2,2,2,2,3,3,3,3), activity=c(1,1,2,2,1,1,2,2,1,1,2,2), val=c(1,2,1,3,1,2,1,2,1,2,1,2) )

df_melt <- melt(df, id = c("subject", "activity"), measure.vars=c("val"))
melt()
df_cast <- dcast(df_melt, subject + activity ~ ..., mean)
df_cast2 <- dcast(df_melt, activity ~ ., sum)
