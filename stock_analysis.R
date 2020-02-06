# exploratory analysis of the stocks -----------------------------------
library(readr)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(tidyr)
library(xts)

all_stocks <- read_csv('./data/all_stocks_5yr.csv')
head(all_stocks)
some_stocks <- all_stocks %>%
  filter(Name == c('AAPL','BABA','FB','IBM','MSFT'))

#portfolio weights (weights of each investment relative to all investment in the portfollio)
ini_values <- c(1000,500,2000)
weights <- ini_values/sum(ini_values)
print(weights)

# Define marketcaps
marketcaps <- c(5, 100, 500, 700, 2000) 

# Compute the weights
weights <- marketcaps/sum(marketcaps)

# Inspect summary statistics
summary(weights)

# Create a bar plot of weights
barplot(weights)

#portfolio return
ini_values <- c(1000,500,2000)
weights <- ini_values/sum(ini_values)
fin_values <- c(800, 6000, 2300)
returns <- (fin_values - ini_values)/ini_values
preturns <- sum((fin_values - ini_values)/ini_values *weights)

#creat dataframe of apple and microsoft stock
aapl_df <- some_stocks %>%
  filter(Name == c('AAPL')) %>%
  select(date, close) %>%
  rename(AAPL = close)

msft_df <- some_stocks %>%
  filter(Name == c('MSFT')) %>%
  select(date, close) %>%
  rename(MSFT = close)

# aapl_msft_df <- some_stocks %>%
#   filter(Name == c('AAPL','MSFT')) %>%
#   select(date, close, Name) %>%
#   spread(Name, close)  

aapl_msft_df <- aapl_df %>%
  inner_join(msft_df, by = 'date')
class(aapl_msft_df)
lapply(aapl_msft_df, class) #data type of each column

#convert dataframe to timeseries 
aapl_msft_xts <- xts(aapl_msft_df[, -1], order.by=as.POSIXct(aapl_msft_df$date))

# Load package PerformanceAnalytics 
library(PerformanceAnalytics)

# Create the variable returns using Return.calculate()  
returns <- Return.calculate(aapl_msft_xts) 

# Print the first six rows of returns. Note that the first observation is NA, because there is no prior price.
head(returns)

# Remove the first row of returns
returns <- returns[-1, ]    

