library(shiny)
library(plotly)
library(dplyr)
library(readxl)
data <- read_excel("Sampledata2.xlsx")

ui <- fluidPage(
  titlePanel("0.2 Create Plots"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("state", "Select State:", unique(data$State)),
      selectInput("year", "Select Year:", unique(data$Year))
    ),
    
    mainPanel(
      plotlyOutput("statePlot"),
      plotlyOutput("yearPlot")
    )
  )
)

server <- function(input, output) {
  
  stateData <- reactive({
    filter(data, State == input$state)
  })
  
  output$statePlot <- renderPlotly({
    plot_ly(stateData(), x = ~Year, y = ~CrimeRate, type = 'scatter', 
            mode = 'lines', name = 'Value') %>%
      layout(title = paste("Crime Rate Changes Over Year"))
  })
  
  yearData <- reactive({
    filter(data, Year == input$year)
  })
  
  output$yearPlot <- renderPlotly({
    plot_ly(yearData(), x = ~CrimeRate, type = 'histogram', nbinsx = 10) %>%
      layout(title = paste("Crime Rate Histogram over all States"))
  })
}

shinyApp(ui=ui, server=server)

