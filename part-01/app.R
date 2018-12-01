# Load packages ----------------------------------------------------------------
library(shiny)
library(tidyverse)
data(diamonds)
library(tools)

# UI ---------------------------------------------------------------------------
ui <- fluidPage(

  titlePanel("Diamonds browser"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("Carat" = "carat", 
                              "Depth" = "depth", 
                              "Table" = "table", 
                              "Price" = "price"), 
                  selected = "carat"),
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("Carat" = "carat", 
                              "Depth" = "depth", 
                              "Table" = "table", 
                              "Price" = "price"), 
                  selected = "depth"),
      selectInput(inputId = "z", 
                  label = "Color by:",
                  choices = c("Cut" = "cut", 
                              "Color" = "color", 
                              "Clarity" = "clarity"),
                  selected = "cut")),
    mainPanel(plotOutput(outputId = "scatterplot"))
    
  )
)

# Server -----------------------------------------------------------------------

server <- function(input, output) {
  
  # Create scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = diamonds, aes_string(x = input$x, y = input$y,
                                              color = input$z)) +
      geom_point() +
      labs(x = toTitleCase(str_replace_all(input$x, "_", " ")),
           y = toTitleCase(str_replace_all(input$y, "_", " ")),
           color = toTitleCase(str_replace_all(input$z, "_", " ")))
  })

    }

# Create Shiny app object ------------------------------------------------------

shinyApp(ui = ui, server = server)

