library(shiny)
library(tidyverse)
function(input, output) {
  
  output$main_plot <- renderPlot({
      p <- ggplot(data = faithful, aes(x = eruptions)) + 
      geom_histogram(aes(y=..density..),bins = as.numeric(input$n_breaks),
                     color = "black") +
      labs(title = "Geyser eruption duration", 
           x = "Duration (minutes)")
    if (input$individual_obs) {
      p <- p + geom_rug()
    }
    
    if (input$density) {
      p <- p + geom_density(colour="blue",
                         adjust=input$bw_adjust)
    }
    print(p)
    
  })
  
  output$scatter_plot <- renderPlot({
    scatter <- ggplot(data = faithful, aes(x = eruptions, y = waiting)) + 
      geom_point(size = input$point.size, alpha = 0.8) +
      labs(title = "Geyser eruption vs. waiting time", 
           x = "Duration (minutes)", 
           y = "Waiting time")
    print(scatter)
    if (input$smooth.line) {
      print(scatter+geom_smooth(method = "lm", se = FALSE))
    }
  })
  output$countour <- renderPlot({
    contour <- ggplot(data = faithful, 
           aes(x = eruptions, 
               y = waiting)) + 
      labs(title = "Contour map of Geyser eruption vs. waiting time") + 
      geom_density2d()
    print(contour)
    if (input$points.visible){
      print(contour + geom_point())
    }
  })
}