library(shiny)
library(ggplot2)

source("gradevis.R")

ui <- fluidPage(
  titlePanel("Grade Visualizer"),
  
  sidebarLayout(
    
    sidebarPanel(
      h4("Grades Distribution"),
      tableOutput("grades_distribution")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Barchart", plotOutput("barchart")), 
        tabPanel("Histogram", verbatimTextOutput("hist")), 
        tabPanel("Scatterplot", tableOutput("scatterplot"))
      )
    )
  )
)

server <- function(input, output) {
  output$grades_distribution <- renderTable(grades_distribution)
  output$barchart <- renderPlot({
    grades <- grades_distribution[["Grade"]]
    freqs <- grades_distribution[["Freq"]]
    data <- data.frame(grades, freqs)
    g <- ggplot(data, aes(grades, freqs))
    g <- g + geom_bar(stat = "identity", color = "skyblue3", fill = "skyblue3",
                 alpha = 0.8)
    g <- g + labs(x = "Grade", y = "Frequency")
    g + coord_cartesian(ylim=c(0, 55)) + scale_y_continuous(breaks = c(seq(0, 60, by = 5)))
  })
}

shinyApp(ui = ui, server = server)
