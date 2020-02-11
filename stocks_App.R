library(shiny)
library(ggplot2)
library(dplyr)
library(readr)

all_stocks <- read_csv('./data/all_stocks_5yr.csv')

ui <- fluidPage(
  sidebarLayout(
  sidebarPanel(
  textInput('stock_symbol', 'Enter stock symbol: ', 'AAPL')),
  mainPanel(
  textOutput("symbol"),
  plotOutput('trend'))
  )
)
server <- function(input, output){
  output$symbol <- renderText({
    paste(toupper(input$stock_symbol), 'stock time-series plot')
  })
 output$trend <- renderPlot({
   ggplot(subset(all_stocks, Name == toupper(input$stock_symbol))) +
     geom_line(aes(x = date, y = close)) +
     labs(y = 'stock price (dollars)')
 }) 
}
shinyApp(ui = ui, server = server)