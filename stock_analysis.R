# exploratory analysis of the stocks -----------------------------------
library(readr)
library(ggplot2)
library(dplyr)

all_stocks <- read_csv('./data/all_stocks_5yr.csv')
head(all_stocks)
some_stocks <- all_stocks %>%
  filter(Name == c('BABA','FB','IBM','MSFT'))

#portfolio weights (weights of each investment relative to all investment in the portfollio)
my_portfolio <- c(4000,4000,2000)
weights <- my_portfolio/sum(mmy_portfolio)

# Make a time series plot of stock ratio
plot.zoo(ratio)

# Add as a reference, a horizontal line at 1
abline(h=1)

