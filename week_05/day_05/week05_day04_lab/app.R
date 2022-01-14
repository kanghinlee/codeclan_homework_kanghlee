
# Week05_day03_lab_Task01 - Height and Arm Span vs Age

library(tidyverse)
library(shiny)
library(DT)

students_big <- CodeClanData::students_big
ageyears <-unique(students_big$ageyears)

ui <- fluidPage(
    
    titlePanel("Height and Arm Span vs Age"),
    
    #--------------------- Row ---------------------#
    fluidRow(
        # Using fluid row to put items on a row
        # Needs to assign column(s) to shiny app, max width = 12
        column(3,
               radioButtons(
                   "age_input",
                   "Age",
                   choices = unique(ageyears),
                   inline = TRUE)
                )
    ),    
    #--------------------- Row ---------------------#
    # Add in another row here with plots
    fluidRow(
        column(6, 
               plotOutput("height_plot_output")
        ),
        
        column(6,
               plotOutput("arm_span_plot_output")
        )    
    ),
)



server <- function (input, output) {
    
    #--------------------- Reactive Dataset ---------------------#   

    filtered_data_reactive <- reactive ({students_big %>%
                filter(ageyears == input$age_input)
                                })

    
    student_big %>% 
        filter(ageyears == 13) %>% 
        ggplot()+
        geom_histogram(aes(x = arm_span))
    

    #--------------------- Plot 1 - Height Plot ---------------------#   
    output$height_plot_output <- renderPlot({
        # adding "()" to show that it is reactive variable
        filtered_data_reactive() %>% 
            ggplot()+
            geom_histogram(aes(x = height))
    })
    
    #--------------------- Plot 2 - Arm Span Plot ---------------------#   
    output$arm_span_plot_output <- renderPlot({
        filtered_data_reactive() %>% 
            ggplot()+
            geom_histogram(aes(x = arm_span))
    })    
    
    # End of server function
}


#--------------------- Run the application ---------------------#  
shinyApp(ui = ui, server = server)
