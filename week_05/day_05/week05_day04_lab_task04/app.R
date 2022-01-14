# Week05_day03_lab_Task04 - An app with tabs
# Comparing Importance of Internet Access vs. Reducing Pollution

library(shiny)
library(tidyverse)
library(DT)

student_big <- CodeClanData::students_big


task_04_gender_choices = c(Male = "M", Female = "F")
task_04_region = unique(student_big$region)


#--------------------- UI Section ---------------------# 
ui <- fluidPage(
    
    #--------------------- Title ---------------------#    
    titlePanel("Task04 - An app with tabs"),
    
    
    #--------------------- Sidebar input ---------------------#,
    sidebarLayout(
        sidebarPanel(
            selectInput("gender_input",
                        "Gender",
                        choices = task_04_gender_choices
            ),
            selectInput("region_input",
                        "Region",
                        choices = task_04_region
            ),

            actionButton("update_button",
                         "Generate Plots and Table")
        ),
        # End of Sidebar Panel
        
        
        #--------------------- Main Panel Output Plot ---------------------#    
    mainPanel(
    tabsetPanel(
        tabPanel(
            "Plots",
            fluidRow(
                column(6,
                       plotOutput("plot1_ouput")
                ),
                column(6,
                       plotOutput("plot2_ouput")
                )
                # ↑ End of Columns  
            )
            # ↑ End of Fluid Row  
        ),
        # ↑ End of Tab Panel  
        tabPanel(
            "Data",
            DT::dataTableOutput("table_output") 
        )
        # ↑ End of Tab Panel  

    )
    # ↑ End of TabsetPanel     
    )
    # ↑ End of Main Panel  

             
  
)
# ↑ End of Sidebar Layout
)
# ↑ End of UI function 


#--------------------- Function Section ---------------------#  
server <- function(input, output) {

#--------------------- Event Reactive Dataset ---------------------#  
    filtered_data <- eventReactive(input$update_button, {
        student_big %>% 
            select(region, gender, importance_internet_access, importance_reducing_pollution) %>% 
            filter(gender == input$gender_input  & region == input$region_input)
    }) 
    
#--------------------- Main Table ---------------------#       
    output$table_output <- DT::renderDataTable({
        filtered_data()
    })
    
#--------------------- Plot 1 ---------------------# 
    output$plot1_ouput <-  renderPlot({
        filtered_data() %>% 
        ggplot(aes(x = importance_internet_access)) +
        geom_histogram(bins = 30)
    })
#--------------------- Plot 2 ---------------------#    
    output$plot2_ouput <- renderPlot({
        filtered_data() %>%  
        ggplot(aes(x = importance_reducing_pollution)) +
        geom_histogram(bins = 30)
    })
    
}
# ↑ Function

# Run the application 
shinyApp(ui = ui, server = server)
