# Load packages ----------------------------------------------------------------
install.packages("shinythemes")

library(shiny)
library(tidyverse)
library(tools)
library(shinythemes)

# Load data --------------------------------------------------------------------
players1 <- read_csv("data/players1.csv")

# UI ---------------------------------------------------------------------------
ui <- fluidPage(
  theme = shinytheme("cyborg"),
        titlePanel("Players browser"),
        sidebarLayout(
            sidebarPanel(
                selectInput(inputId = "y", 
                        label = "Y-axis:",
                        choices = c("Position" = "position", 
                                    "Age" = "age", 
                                    "Matches" = "matches", 
                                    "Goals" = "goals",
                                    "Own Goals" = "own_goals",
                                    "Assists" = "assists",
                                    "Yellow Cards" = "yellow_cards",
                                    "Red Cards" = "red_cards",
                                    "Substituted On" = "substituted_on",
                                    "Substituted Off" = "substituted_off",
                                    "Market Value" = "market_value",
                                    "Age Range" = "age_range"), 
                        selected = "position"),
                selectInput(inputId = "x", 
                        label = "X-axis:",
                        choices = c("Position" = "position", 
                                    "Age" = "age", 
                                    "Matches" = "matches", 
                                    "Goals" = "goals",
                                    "Own Goals" = "own_goals",
                                    "Assists" = "assists",
                                    "Yellow Cards" = "yellow_cards",
                                    "Red Cards" = "red_cards",
                                    "Substituted On" = "substituted_on",
                                    "Substituted Off" = "substituted_off",
                                    "Market Value" = "market_value",
                                    "Age Range" = "age_range"), 
                         selected = "market_value"),
                 selectInput(inputId = "z", 
                         label = "Color by:",
                         choices = c("Position" = "position", 
                                     "Age" = "age", 
                                     "Matches" = "matches", 
                                     "Goals" = "goals",
                                     "Own Goals" = "own_goals",
                                     "Assists" = "assists",
                                     "Yellow Cards" = "yellow_cards",
                                     "Red Cards" = "red_cards",
                                     "Substituted On" = "substituted_on",
                                     "Substituted Off" = "substituted_off",
                                     "Market Value" = "market_value",
                                     "Age Range" = "age_range"), 
                           selected = "age")),
                 mainPanel(plotOutput(outputId = "scatterplot"))
                  
           )
)


# Server -----------------------------------------------------------------------

server <- function(input, output) {
  
  # Create scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = players1, aes_string(x = input$x, y = input$y,
                                       color = input$z)) +
      geom_point() +
      labs(x = toTitleCase(str_replace_all(input$x, "_", " ")),
           y = toTitleCase(str_replace_all(input$y, "_", " ")),
           color = toTitleCase(str_replace_all(input$z, "_", " ")))
  })
  
}



# Create Shiny app object ------------------------------------------------------
shinyApp(ui = ui, server = server)