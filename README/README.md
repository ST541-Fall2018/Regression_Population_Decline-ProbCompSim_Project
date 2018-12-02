---
title: "README"
author: "Peter Boyd"
date: "10/17/2018"
output: html_document
---

Name: Peter Boyd

Project Title: Modeling Population Decline of Endangered Species

Report: Found in Presentation and Report folder  [here](https://github.com/ST541-Fall2018/boydpe-project-populationdecline/blob/master/Presentation%20and%20Report/Modeling_Population_Decline_Report.pdf)

Description: In this project, I model the population decline of endangered species and predict when the species may become extinct. This is done via a function that performs the following steps:
    
    1) Fits several different models
    2) Selects the best model by comparing AIC values
    3) Using fitted values from the best model, simulate many versions of new data
    4) Refit glm's, using original year values and simulated population
    5) Average fits, roughly estimate when population is zero
    5) Show graphically the fit of various models and the residual plot of best model
    
I strucutred my project in the following manner:

    1) Each week I created a single issue in my git, outlining the tasks I hoped to complete that week, commiting to that issue and making comments in it as I worked. 
    2) Each week I had a new Rmd file, housed in "Weekly R Files" to help track my progress and keep thoughts organized. 
    3) The "Essential Codes and Examples" folder houses the finalversion of my function and an example of its implementation
    
Packages required: tidyverse, here, MASS


    