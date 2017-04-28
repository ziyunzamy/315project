library(shiny)
library(shinydashboard)
shinyUI(dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("PartA", tabName = "PartA", icon = icon("th")),
      menuItem("PartB", tabName = "PartB", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "PartA",
              fluidRow(
                box(plotOutput(outputId = "main_plot", height = "250")),
                
                box(
                  title = "Controls",
                  selectInput(inputId = "n_breaks",
                              label = "Number of bins in histogram (approximate):",
                              choices = c(10, 20, 35, 50),
                              selected = 20),
                  checkboxInput(inputId = "individual_obs",
                                label = strong("Show individual observations"),
                                value = FALSE),
                  
                  checkboxInput(inputId = "density",
                                label = strong("Show density estimate"),
                                value = FALSE),
                  
                  # Display this only if the density is shown
                  conditionalPanel(condition = "input.density == true",
                                   sliderInput(inputId = "bw_adjust",
                                               label = "Bandwidth adjustment:",
                                               min = 0.2, max = 2, value = 1, step = 0.2))
                )
              )),
      tabItem(tabName = "PartB", 
              tabsetPanel(
                tabPanel("Plot1", 
                         fluidRow(
                           box(plotOutput(outputId = "scatter_plot", height = "300px")),
                           box(
                             title = "Controls",
                             checkboxInput(inputId = "smooth.line",
                                           label = strong("Show Fitted Line"),
                                           value = FALSE),
                             sliderInput(inputId = "point.size",
                                         label = "point size:",
                                         min = 1, max = 10, value = 5, step = 1)
                           )
                         )),
                tabPanel("Plot2", fluidRow(
                  box(plotOutput(outputId = "countour", height = "300px")),
                  box(
                    title = "Controls",
                    checkboxInput(inputId = "points.visible",
                                  label = strong("Show Points"),
                                  value = FALSE))
                ))
              )
              )
    )
  )

 
))