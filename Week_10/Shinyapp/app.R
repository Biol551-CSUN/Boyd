library(shiny)
library(tidyverse)

ui <- fluidPage(
  sliderInput(inputId = "num", # ID name for input
              label = "Choose a number", #label above the input
              value = 25, min = 1, max = 100 # values for the slider
              ),
  textInput(inputId = "title",
            label = "Write a title",
            value = "Histogram of Random Normal Values"),
  plotOutput("hist"), # creates space for a plot called hist
  verbatimTextOutput("stats") # creates a space for stats
) # user interface

server <- function(input, output){
  
  data <- reactive({
    tibble(x = rnorm(input$num))
  })
  
  output$hist <- renderPlot({
    ggplot(data(), aes(x = x)) + # make a histogram
      geom_histogram() +
      labs(title = input$title) # adds a new title
  })
   output$stats <- renderPrint({
     summary(data()) # calculate summary stats based on the numbers
   })
} # code goes here

shinyApp(ui = ui, server = server)