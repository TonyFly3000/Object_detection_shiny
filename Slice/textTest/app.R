sayMessageUI <- function(id) {
  ns <- NS(id) #namespace function for keeping message unique
  p( textOutput(ns("sayMessage")) )
}
sayMessage <- function(input, output, session, message = "hi") {
  output$sayMessage <- renderText({ message });
}
ui <- fluidPage(
  titlePanel("useR Brussles Example"),
  sayMessageUI("message1"),
  sayMessageUI("message2")
)
server <- function(input, output) {
  message_1 <- callModule(sayMessage, "message1", "I'm just here for the")
  message_2 <- callModule(sayMessage, "message2", "beer and chocolate.")
}
# Run the application 
shinyApp(ui = ui, server = server)

