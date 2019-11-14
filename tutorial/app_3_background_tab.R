# if you do not have shiny ,please install 
# install.packages('shiny')


library('shiny')

###########  ui #####################
ui = fluidPage( titlePanel("Object detection  with Shiny"),
                sidebarLayout(
                  
                  
                  sidebarPanel(
                    tabsetPanel(type = "tabs",
                                 tabPanel("model"),
                                 tabPanel("photo editor")
                                 )
                              ),
                  mainPanel(
                    
                    
                    tabsetPanel(type = "tabs",
                                tabPanel("photo"),
                                tabPanel("model summary")
                    )
                    
                    
                  )
                )
                
)



###########  server  #####################
server=function(input, output,session){}

# Run the app ----
shinyApp(ui = ui, server = server)