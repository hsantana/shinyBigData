# server.R

library(quantmod)
source("helpers.R")


shinyServer(function(input, output) {
  
  dataInput <- reactive({  
    getSymbols(input$symb, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  dataInput2 <- reactive({
    if (!input$adjust) return(dataInput())
    adjust(dataInput())
  })
  
  output$plot <- renderPlot({
    chartSeries(name='Final Graph', 
                dataInput2(), 
                theme = chartTheme("black"),
                type = "line", 
                log.scale = input$log, 
                TA = NULL)
  })
})