# if you do not have shiny ,please install 
# install.packages('shiny')


library('shiny')

###########  ui #####################
ui = fluidPage()



###########  server  #####################
server=function(input, output,session){}

# Run the app ----
shinyApp(ui = ui, server = server)