library(tidyverse)
library(shiny)

# use data "strawberries" as it is cleaned and reorganized.
sberry<-as.data.frame(read.csv("strawberries.csv"))
#sberry<- select(sberry, c("Year", "State", "type"))

ui <- fluidPage(
    title = "Examples of Data Tables",
    sidebarLayout(
        tabsetPanel(
        conditionalPanel(
            'input.dataset === "sberry"',
        )

        ),
        
        mainPanel(
            tabsetPanel(
                id = 'dataset',
                tabPanel("Strawberries of the year",
                         
                         # Create a new Row in the UI for selectInputs
                         fluidRow(
                          
                             column(4,
                                    selectInput("Year",
                                                "Year:",
                                                c("All",
                                                  unique(sberry$Year)))
                             )
                         ),
                         # Create a new row for the table.
                         DT::dataTableOutput("table1"))
                
                         )
        )
    )
)




server <- function(input, output) {
    
    # Filter data based on selections
    output$table1 <- DT::renderDataTable(DT::datatable({
        data <- sberry
        if (input$Year != "All") {
            data <- data[data$Year == input$Year,]
        }
        
        data
    })
    )
    
    

    
}

# Run the application 
shinyApp(ui = ui, server = server)


