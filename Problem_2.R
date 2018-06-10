## Homework 2 / Problem 2
## Problem description:
## https://firebasestorage.googleapis.com/v0/b/uni-sofia.appspot.com/o/homeworks%2FHomework_2.pdf?alt=media

## Install the following packages if necessary
## install.packages(c('ggplot2', 'dplyr'))

library(dplyr)
library(ggplot2)

# Enter your student ID in set.seed() so that your results are reproducible, i.e. run set.seed(3304)
## and replace 3304 with your student id.
set.seed(2616)

# use the rnorm function to generate values from the standard normal distribution
# you can compute e^x with the exp function, e.g. e^2 = exp(2).

## Draw n * R values at random from the standard normal distribution
## Note: you need to define n, R and furthermore mu and sigma.
z <- rnorm(n * R)
x <- exp(mu + sigma * z)

## x is now a sample of log-normally distibuted population and you can apply
## the methods used in the simulation in Problme set 2/Problem 1.

mu <- 1
sigma <- 1.3

## a)
mux <- exp(mu + sigma ^ 2 / 2)
varx <- (exp(sigma ^ 2) - 1) * exp(2 * mu + sigma ^ 2)

## b)
B <- 5000 ## Number of samples
n <- 1000 ## Sample size

z <- rnorm(B * n)
x <- exp(mu + sigma * z)

## c)
samplesData <- data.frame(minutes = x, r = rep(1:B, each = n))

groupedSamples <- group_by(samplesData, r)
samplesSummary <- summarise(
  groupedSamples,
  sampleMean = mean(minutes)
)

## d)
ggplot(data = samplesSummary, aes(x = sampleMean)) + 
  geom_histogram(bins=50) + geom_vline(xintercept = mux, color = 'red')

## The distribution of the sample means is roughly symmetrical 
## and is centered close to the population mean.
## The histogram of the samples means roughly resembles 
## a histogram of data that comes from a normal distribution.

## The central limit theorem states that the average of a large number of
## independent random variables will be approximately normally distributed.

## e)
mean(samplesSummary$sampleMean)
sd(samplesSummary$sampleMean)
