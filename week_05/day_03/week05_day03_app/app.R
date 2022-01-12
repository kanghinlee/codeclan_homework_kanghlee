library(shiny) #1. call packages
library(tidyverse)
library(shinythemes)

olympics_medals <- CodeClanData::olympics_overall_medals
countries <- unique(olympics_medals$team)

# 2. define UI
ui <- fluidPage(
    
    theme = "shiny_example_style.css",
    
    titlePanel("Week05 Day 03 Homework - Total Medal Count for chosen country"),
    
    tabsetPanel(
        tabPanel(
            "Plot",
            plotOutput(outputId = "medal_plot"),
        ),
        tabPanel(
            "Inputs",
            column(
                width = 6,
                radioButtons(
                    inputId = "season_input",
                    label = "Summer or Winter Olympics?",
                    choices = c("Summer", "Winter")
                ),
            ),
            column(
                width = 6,
                selectInput(
                    inputId = "team_input",
                    label = "Which Country?",
                    choices = countries
                ),
            ),
        ),
        
    ),
)


# 3. define server
server <- function(input, output) {
    
    #creates output object: medal_plot
    output$medal_plot <-       renderPlot({ 
        
        olympics_medals %>%
            filter(season == input$season_input) %>%
            group_by(team) %>% 
            summarise(count = sum(count)) %>% 
            ggplot(aes(x = input$team_input, y = count, fill = input$team_input)) +
            geom_col()+
            labs(
                x = "\n Countries",
                y = "Medal Count",
                title = "Medal Country for chosen country"
            )
        
    })
    
    
}

shinyApp(ui = ui, server = server)