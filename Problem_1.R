## Homework 2 / Problem 1
## Problem description:
## https://firebasestorage.googleapis.com/v0/b/uni-sofia.appspot.com/o/homeworks%2FHomework_2.pdf?alt=media

## Install the following packages if necessary. Uncomment the following line and execute it.
## install.packages(c('dplyr', 'ggplot2'))

## Load packages

library(dplyr)
library(ggplot2)

## Download and read the data
wines <- read.csv(file='https://s3.eu-central-1.amazonaws.com/sf-timeseries/data/wine.csv')
str(wines)
## a)
wines <- within(wines, {
  Price <- exp(LogPrice)
})

## b)
wines <- within(wines, {
  tempclass <- ifelse(Temperature > mean(Temperature), 'hot', 'cold')
})

# Example using ifelse
## ifelse(c(TRUE, TRUE, FALSE, TRUE), 'condition TRUE', 'condition FALSE')

## c)
table(wines$tempclass)
# Example using table
## table(c('category1', 'category1', 'category2'))

## d)

winesByTempClass <- group_by(wines, tempclass)
winesByTempSummary <- summarise(winesByTempClass, 
                          meanPrice = mean(Price),
                          sdPrice = sd(Price),
                          maxPrice = max(Price),
                          minPrice = min(Price),
                          medianPrice = median(Price),
                          nGroup = length(Price) ## In preparation for g)                          
                          )

## or equivalently using pipes
winesByTempSummary <- 
  wines %>%
  group_by(tempclass) %>%
  summarise(
    meanPrice = mean(Price),
    sdPrice = sd(Price),
    maxPrice = max(Price),
    minPrice = min(Price),
    medianPrice = median(Price),
    nGroup = length(Price) ## In preparation for g)
  )
  
## e)
ggplot(data = wines, aes(x = tempclass, y = Price)) + geom_boxplot()

## The boxplot indicates that wine prices were higher 
## for wines produced in 'hot' years than in cold years (position of box)
## The variance of the prices appears to be higher in hot than 
## in cold years (length of the box).

## f)
ggplot(data = wines) + stat_qq(aes(sample = Price))

## The points in the qq-plot do not appear to lie on a straight line.
## This indicates that the sample of prices does not appear to come
## from a normal distribution

## g)

within(winesByTempSummary, {
  lower <- meanPrice - qt(0.95, df = nGroup - 1) * sdPrice / sqrt(nGroup)
  upper <- meanPrice + qt(0.95, df = nGroup - 1) * sdPrice / sqrt(nGroup)
})

## The confidence interval based on the t-distribution requires
## that the data (here: wine prices) is normally distibuted
## or a large sample size.
## The sample size is rather small (14 for hot years and 13 for cold years)
## The data does not appear to be normally distributed: see part f) above.
