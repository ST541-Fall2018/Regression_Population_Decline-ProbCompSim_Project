# Peter Boyd
# Modeling Population Decline Function


pop.decline <- function(df, ntimes){
  #fit several models
  df <- na.omit(df)
  fit.glm <- glm(df$Population ~ df$Year, data = df)
  fit.poi <- glm(df$Population ~ df$Year, data = df, family = "poisson")
  fit.nb <- glm.nb(df$Population ~ df$Year, data = df)
  fits <- list((fit.glm), (fit.poi), (fit.nb))
  #####
  
  #compare AIC
  mods <- c("Linear Model", "Poisson", "Negative Binomial")
  aics <- c(summary(fit.glm)$aic, summary(fit.poi)$aic, summary(fit.nb)$aic)
  best_model <- fits[[order(aics)[1]]]
  aic_summary <- cat("AIC for Each Model", "\n",
                     mods[1], ": ", aics[1], "\n", 
                     mods[2], ": ", aics[2], "\n",
                     mods[3], ": ", aics[3], "\n")
  #####
  
  # do simulation for lowest aic
  # first, select best model and simulate accordingly
  # then, fit models to each simulation
  # finally, average the models to obtain an approximate 
  # estimate of extinction date
  n <- max(df$Year) - min(df$Year) +1
  y.hat <- best_model$fitted.values
  
  if(order(aics)[1] == 2){
    y.rep <- matrix(ncol = ntimes, data = c(rpois(n*ntimes, y.hat)))
  } else if(order(aics)[1] == 3){
    y.rep <- matrix(ncol = ntimes, data = c(rnegbin(n = n*ntimes, mu = y.hat, 
                                                    theta = summary(fit.nb)$theta)))
  } else {
    new_data <- data.frame("Year" = seq(max(df$Year)+1, max(df$Year) + n*ntimes, 1))
    preds <- predict(fit.glm, newdata = new_data, type = 'response')
    preds <- preds + runif(n = n*ntimes, min = min(fit.glm$residuals), max =  
                             max(fit.glm$residuals))
    y.rep <- matrix(ncol = ntimes, data = preds)
  }
  
  years <- c(min(df$Year):max(df$Year))
  y.rep.sort <- -apply(-y.rep, 2, sort)
  y.coefs <- t(apply(y.rep.sort, 2, function(y.col) lm(y.col~years)$coef))
  end.dates <- -y.coefs[,1] / y.coefs[,2]
  end.date <- cat("Predicted Extinction: ", mean(end.dates))
  #####
  
  #create plot with each model fit
  plot1 <- ggplot(data = df, aes(x = Year, y = Population)) +
    geom_point() +
    geom_smooth(method='glm',formula=y~x, method.args = list(family = "poisson"), 
                aes(color = "Poisson")) +
    geom_smooth(method='glm',formula=y~x, aes(color = "Linear")) + 
    geom_smooth(method='glm.nb',formula=y~x, aes(color = "Neg.Bi")) +
    scale_colour_manual(name="legend", values=c("orange", "green", "purple")) +
    labs(x = "Year", y = "Population")
  #####
  
  #create plot for lowest aic model
  aug.best_model <- augment(best_model)
  resid.plot1 <- ggplot(aug.best_model, aes(x = .fitted, y = .resid)) +
    geom_point()
  
  print_plots <- function(x, y){
    {par(mfrow = c(1,2))
      print(x)
      print(y)}
  }
  #####
  
  #return aics, predicted extinction, plots
  return(list(aic_summary, end.date, print_plots(plot1, resid.plot1)))
}