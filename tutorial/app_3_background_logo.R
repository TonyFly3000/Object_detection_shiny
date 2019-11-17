# if you do not have shiny ,please install 
# install.packages('shiny')
#options(repos = BiocInstaller::biocinstallRepos())
#getOption("repos")



library('shiny')

###########  ui #####################
ui = fluidPage( 


  
  titlePanel(title=div(img(src="logo.jpg"),"Object detection  with Shiny")),
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