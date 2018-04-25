# Homework 2
# Problem 2

# Install the following packages if necessary
# install.packages(c('ggplot2', 'dplyr'))

library(dplyr)
library(ggplot2)

# Enter your student ID in set.seed() so that your results are reproducible, i.e. run set.seed(3304)
## and replace 3304 with your student id.
set.seed()

# use the rnorm function to generate values from the standard normal distribution
# you can compute e^x with the exp function, e.g. e^2 = exp(2).

## Draw n * R values at random from the standard normal distribution
## Note: you need to define n, R and furthermore mu and sigma.
z <- rnorm(n * R) ## 
x <- exp(mu + sigma * z)

## x is now a sample of log-normally distibuted population and you can apply
## the methods used in the simulation in Problme set 2/Problem 1.

## a)

## b)

## c)

## d)
