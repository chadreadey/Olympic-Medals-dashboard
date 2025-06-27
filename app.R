library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(dplyr)

# Load the data 
medals <- read.csv("data/medals.csv")

ui <- dashboardPage(
  dashboardHeader(
    title = "Medal Tracker",
    dropdownMenu(
      type = "notification",
      badgeStatus = "info",
      headerText = "Citation",
      notificationItem(icon = icon("users"), "Kaggle Data",
                       href = "https://www.kaggle.com/datasets/piterfm/paris-2024-olympic-summer-games/data?select=medals.csv"))
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem(
        "Filters", 
        tabName = "filters", 
        icon = icon("filter")
      ),
      selectInput(
        "country", 
        "Select Country", 
        choices = unique(medals$country)
      ),
      selectInput(
        "discipline", 
        "Select Discipline", 
        choices = unique(medals$discipline)
      )
    )
  ),
  dashboardBody(
    fluidRow(
      box(
        title = "Medal Distribution by Event", 
        status = "primary", 
        solidHeader = TRUE, 
        plotOutput("medalPlot")
      ),
      box(
        title = "Medal Details",
        status = "primary", 
        solidHeader = TRUE, 
        DT::dataTableOutput("medalTable"))
    ),
    fluidRow(
      box(
        title = "Top 3 Countries by Medal Count", 
        status = "primary", 
        solidHeader = TRUE, 
        plotOutput("top3CountriesPlot")
      ),
      
        box(
          imageOutput("Paris24")
        )
        
      
    )
  )
)

server <- function(input, output, session) {
  
  # Reactive expression to filter the data based on user inputs
  filtered_data <- reactive({
    data <- medals
    
    if (!is.null(input$country)) {
      data <- data[data$country == input$country, ]
    }
    
    if (!is.null(input$discipline)) {
      data <- data[data$discipline == input$discipline, ]
    }
    
    data
  })
  
  # Reactive expression to calculate the top 3 countries by total medals
  top3_countries <- reactive({
    medals %>%
      count(country) %>%
      arrange(desc(n)) %>%
      top_n(3, n)
  })
  
  # Output for the medal distribution plot
  output$medalPlot <- renderPlot({
    data <- filtered_data()
    
    if (nrow(data) == 0) {
      return(NULL)  # Don't plot if there's no data
    }
    
    ggplot(data, aes(x = medal_type, fill = medal_type)) +
      geom_dotplot(binaxis = "x", stackdir = "center", dotsize = 0.5, binwidth = 0.2) +
      scale_fill_manual(values = c("Gold Medal" = "gold", 
                                   "Silver Medal" = "#c0c0c0", 
                                   "Bronze Medal" = "#cd7f32")) +
      labs(title = NULL, x = NULL, y = NULL, fill = "Medal Type") +
      theme_minimal() +
      theme(
        axis.text = element_blank()
      )
  })
  
  # Output for the top 3 countries plot
  output$top3CountriesPlot <- renderPlot({
    data <- top3_countries()
    
    ggplot(data, aes(x = reorder(country, n), y = n, fill = country)) +
      geom_col() +
      coord_flip() +
      scale_fill_manual(values = c(  
                                   "#c0c0c0", 
                                   "#cd7f32",
                                   "gold")) +
      labs(title = NULL, x = "Country", y = "Total Medals") +
      theme_minimal() +
      theme(legend.position = "none")
  })
  
  # Output for the data table showing medal details
  output$medalTable <- DT::renderDataTable({
    DT::datatable(filtered_data()[, c("country", "discipline", "event", "medal_type", "name")], 
                  options = list(pageLength = 10), 
                  rownames = FALSE)
  })
  output$Paris24 <- renderImage({
    
    list(src = "images/paris-olympics-2024.webp",
         width = "700px",
         height = "400px"
        )
    
  }, deleteFile = F)
}

shinyApp(ui, server)
