# Week05_day03_lab_Task02 - Reaction Time vs. Memory Game

library(shiny)
library(tidyverse)
student_big <- CodeClanData::students_big


task_02_choices = c(Blue = "#3891A6", Yellow = "#FDE74C", Red = "#E3655B")
task_02_shape = c(Square = "15", Circle = "16", Triangle = "17")


#--------------------- UI Section ---------------------# 
ui <- fluidPage(

#--------------------- Title ---------------------#    
titlePanel("Task02 - Reaction Time vs. Memory Game"),


#--------------------- Sidebar input ---------------------#,
sidebarLayout(
    sidebarPanel(
    radioButtons(
        "colour_input",
        "Colour of Points",
        choices = task_02_choices
    ),
    
    sliderInput(
        "alpha_input",
        "Transparency of points",
        min = 0,
        max = 1,
        value = 0.1
    ),
    
    selectInput("shape_input",
                "Shape of Points",
                choices = task_02_shape
    ),
    
    textInput("title_input",
              "Title Graph",
              value = "Enter title..."
    )

                ),
# End of Sidebar Panel


#--------------------- Main Panel Output Plot ---------------------#        
mainPanel(
    plotOutput("task02_plot_output")
    )
# ↑ End of Main Panel    
        )
#  ↑End of Sidebar Layout  
)
# ↑ End of UI function 


#--------------------- Function Section ---------------------#  
server <- function(input, output) {

    output$task02_plot_output <- renderPlot({
        student_big %>% 
            ggplot(aes(x = reaction_time , y = score_in_memory_game)) +
            geom_point(
                shape = as.numeric(input$shape_input),
                colour = input$colour_input,
                alpha = input$alpha_input
            ) +
            ggtitle(input$title_input)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
