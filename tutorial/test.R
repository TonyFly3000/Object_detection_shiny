library(shiny)

ui <- fluidPage(
  
  titlePanel(title=div(img(src="logo.jpg")))
)

server <- function(input, output, session){
  
}

shinyApp(ui, server)