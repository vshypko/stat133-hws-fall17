# ===================================================================
# Title: HW 04: Grades Visualizer
# Description: Shiny App
# Input(s): cleanscores.csv
# Output(s): application that visualizes the data
# Author: Vitali Shypko
# Date: 11-22-2017
# ===================================================================

# Packages
library(dplyr)
library(ggplot2)
library(ggvis)
library(shiny)

# Functions and data prepared for Shiny App
source("gradevis.R")

dat_clean <- read_csv("../data/cleandata/cleanscores.csv")
vars <- x_variables[-length(x_variables)]

ui <- fluidPage(
  titlePanel("Grade Visualizer"),
  
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(condition = "input.tabselected==1",
                       h4("Grades Distribution"),
                       tableOutput("grades_distribution")
                       ),
      conditionalPanel(condition = "input.tabselected==2",
                       selectInput("var2", "X-axis variable", vars),
                       sliderInput("binwidth2", "Bin Width", 
                                   min = 1, max = 10, value = 10)
                       ),
      conditionalPanel(condition = "input.tabselected==3",
                       selectInput("var3_1", "X-axis variable", vars),
                       selectInput("var3_2", "Y-axis variable", vars,
                                   selected = "HW2"),
                       sliderInput("opacity3", "Opacity", 
                                   min = 0, max = 1, value = 0.5),
                       radioButtons("showline3", "Show line",
                                    c("none"="none", "lm"="lm",
                                      "loess"="loess")
                       )
                       )
      ),

    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Barchart", value = 1, 
                           plotOutput("barchart")
                           ),
                  tabPanel("Histogram", value = 2, 
                           ggvisOutput("histogram"),
                           fluidRow(
                             column(width = 10, 
                                    "Summary Statistics:",  
                                    verbatimTextOutput("summary")))
                           ),
                  tabPanel("Scatterplot", value = 3,
                           ggvisOutput("scatterplot"),
                           fluidRow(
                             column(width = 10, 
                                    "Correlation:",  
                                    verbatimTextOutput("correlation")))
                           ),
                  id = "tabselected")
    )
  )
)

server <- function(input, output) {
  # Barplot and table for 1st tab
  output$grades_distribution <- renderTable(grades_distribution)
  output$barchart <- renderPlot({
    grades <- factor(grades_distribution[["Grade"]],
                     levels = grades_distribution[["Grade"]])
    freqs <- grades_distribution[["Freq"]]
    data <- data.frame(grades, freqs)
    g <- ggplot(data, aes(grades, freqs)) +
      geom_bar(stat = "identity", color = "skyblue3", fill = "skyblue3",
                                                    alpha = 0.8) +
      labs(x = "Grade", y = "Frequency", face = "bold") +
      coord_cartesian(ylim=c(0, 55)) +
      scale_y_continuous(breaks = c(seq(0, 60, by = 5)))
    g + theme(axis.title.x = element_text(face = "bold")) +
      theme(axis.title.y = element_text(face = "bold"))
  })
  
  # Histogram for 2nd tab
  vis_histogram <- reactive({
    var2 <- prop("x", as.symbol(input$var2))
    dat_clean %>% 
      ggvis(x = var2, fill := "#abafb5") %>% 
      layer_histograms(stroke := 'white',
                       width = input$binwidth2)
  })
  vis_histogram %>% bind_shiny("histogram")
  
  # Summary for 2nd tab
  observe({
    x <- input$var2
    output$summary <- renderPrint({
      print_stats(summary_stats(dat_clean[[x]]))
    })
  })
  
  # Scatterplot for 3rd tab
  vis_scatterplot <- reactive({
    var3_1_str <- input$var3_1
    var3_2_str <- input$var3_2
    var3_1 <- prop("x", as.symbol(var3_1_str))
    var3_2 <- prop("y", as.symbol(var3_2_str))
    showline3 <- input$showline3
    
    if (showline3 == "none") {
      dat_clean %>%
        ggvis(x = var3_1, y = var3_2) %>% 
        layer_points(stroke := 'darkgray', opacity := input$opacity3)
    } else if (var3_1_str == var3_2_str && showline3 == "loess") {
      # prevent app from crashing when choosing loess on the same x and y data
      dat_clean %>%
        ggvis(x = var3_1, y = var3_2) %>% 
        layer_points(stroke := 'darkgray', opacity := input$opacity3)
    } else {
      dat_clean %>%
        ggvis(x = var3_1, y = var3_2) %>% 
        layer_points(stroke := 'darkgray', opacity := input$opacity3) %>%
        layer_model_predictions(model = input$showline3, stroke := 'darkblue')
    }
  })
  vis_scatterplot %>% bind_shiny("scatterplot")
  
  # Correlation for 3rd tab
  observe({
    x <- input$var3_1
    y <- input$var3_2
    output$correlation <- renderPrint({
      cat(cor(dat_clean[[x]], dat_clean[[y]]))
    })
  })
}

shinyApp(ui = ui, server = server)
