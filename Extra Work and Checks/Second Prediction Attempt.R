# Peter Boyd
# The code below was included within my function as a secondary attempt to predict extinction. 
# I had hoped to: 

# - use original data to fit a model
# - simiulate data from fitted values
# - fit many models for the simulated values and predict the next value for each model
# - find the average of these predicted values and  assume that this average will be the next "observed" value
# - repeat this process as long as the predicted population is above 1

# Unfortunately, the model would converge to a large value and simply repeat this value
# for thousands of years in a row. 

# After struggling with the attempt for many hours, I decided to cut my losses and 
# use my simpler approach. 


df1 <- df
pop <- df1$Population[n]
y.rep.sort1 <- y.rep.sort
while(pop > 1){
  fitted.pred <- double(ntimes)
  fitted.rep <- vector("list", ntimes)
  for(i in 1:ntimes){
    fitted.rep[[i]] <- glm(y.rep.sort1[,i] ~ df1$Year)
    fitted.pred[i] <- predict(fitted.rep[[i]], data.frame(Year = max(df$Year), type = "response"))
  }
  y.rep.sort1 <- rbind(y.rep.sort1, fitted.pred)
  df1[nrow(df1) + 1,] <- c(df1[nrow(df1),1] + 1, round(mean(y.rep.sort1[nrow(y.rep.sort1),])))
  pop <- df1$Population[nrow(df1)]
  j <- j + 1
}