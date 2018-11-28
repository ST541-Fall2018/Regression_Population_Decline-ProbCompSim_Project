data("cars")
summary(cars.lm)
new.dat <- data.frame(speed=30)

library(tidyverse)
library(here)
library(MASS)
library(broom)
whale <- read_csv(here("data", "sperm_whale_pop.csv"))
df <- whale
df <- as.data.frame(df)
df$Year <- as.numeric(df$Year)
df$Population <- as.numeric(df$Population)

neww <- data.frame(Year = 2000)

########

cars.glm <- glm(dist ~ speed, data = cars)
predict(cars.glm, newdata = new.dat, type = 'response')

fit.glm <- glm(Population ~ Year, data = df)
predict.glm(fit.glm, newdata = neww, type = "response")

coef(glm.fit)


#https://www.r-bloggers.com/prediction-intervals-for-poisson-regression/

#1 and 2 are both done in my function

#redo regressions with the new responses
#

x <- c(1:10)
y <- 
