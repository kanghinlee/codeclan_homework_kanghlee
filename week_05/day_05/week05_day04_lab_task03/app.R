# Week05_day03_lab_Task03 - Three different plot options

library(tidyverse)
library(shiny)
library(DT)


students_big <- CodeClanData::students_big
task03_choice <- c(Bar = "1", Horizontal_Bar = "2", Stacked_Bar = "3")

ui <- fluidPage(
    
titlePanel("Student Handed Count"),
    
    #--------------------- Row ---------------------#

        # Using fluid row to put items on a row
        # Needs to assign column(s) to shiny app, max width = 12
fluidRow(
    column(12,
               radioButtons(
                   "plot_type_input",
                   "Plot Type",
                   choices = task03_choice)
    )
),   
 

    #--------------------- Output Plot ---------------------#
fluidRow(
    column(12,
               plotOutput("barplot_output")
)
)
)



server <- function (input, output) {
    

    
    #--------------------- Reactive Dataset ---------------------#   
    
    
    filtered_data <- reactive({
        task_03 <- student_big %>%
            select(gender, handed) %>% 
            group_by(gender, handed) %>% 
            summarise(count = table(handed))
    }) 
    
    #--------------------- Plot 1 - Travel Plot ---------------------#   
    #     # adding "()" to show that it is reactive variable
    #     if (input$plot_type_input == "1") {
    # output$barplot_output <- renderPlot({               
    #     filtered_data() %>% 
    #         ggplot(aes(x = handed, y = count, fill = gender)) +
    #         geom_col(stat ="identity", position = "dodge")
    # })
    # 
    # } else if (input$plot_type_input == "2") {  
    # output$barplot_output <- renderPlot({    
    #     filtered_data() %>%             
    #     ggplot(aes(x = handed, y = count, fill = gender))+
    #         geom_col(stat="identity", position = "dodge")+
    #         coord_flip()    
    #     })
    # 
    # } else if (input$plot_type_input == "3") {
    # output$barplot_output <- renderPlot({            
    #     filtered_data() %>%             
    #     ggplot(aes(x = handed, y = count, group = gender, fill = gender))+
    #         geom_bar(stat = "identity")
    #      })        
    #     }

    # adding "()" to show that it is reactive variable
    output$barplot_output <- renderPlot({   
    if (input$plot_type_input == "1") {
            
            filtered_data() %>% 
                ggplot(aes(x = handed, y = count, fill = gender)) +
                geom_col(stat ="identity", position = "dodge")
        
    } else if (input$plot_type_input == "2") {  
        
        filtered_data() %>%             
            ggplot(aes(x = handed, y = count, fill = gender))+
            geom_col(stat="identity", position = "dodge")+
            coord_flip()    
        
    } else if (input$plot_type_input == "3") {
        
        filtered_data() %>%             
            ggplot(aes(x = handed, y = count, group = gender, fill = gender))+
            geom_bar(stat = "identity")
    }

    })
        


    
    # End of server function
}


#--------------------- Run the application ---------------------#  
shinyApp(ui = ui, server = server)
