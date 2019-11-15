# if you do not have shiny ,please install 
# install.packages('shiny')


library('shiny')

###########  ui #####################
ui = fluidPage( 
  titlePanel(title=div(img(src="logo.jpg"),"Object detection  with Shiny")),
                sidebarLayout(
                  
                  
                  sidebarPanel(
                    tabsetPanel(type = "tabs",
                                tabPanel("model",
                                         
                                         selectInput('model', 'model:', c('no model','dog_cat_CNN_model','VGG16_dog_cat_cnn_model','mobilenet_model','resnet50_model','tiny_yolo'),selected = 'no model')
                                         ,actionButton("Run_model", "Run_model",class = "butt",)
                                         ,tags$head(tags$style(".butt{background-color:#DF3915;} .butt{color: #FFFFFF;}"))
                                         
                                         ,br(),br(),br()
                                         ,fileInput('input001', 'choose picture') 
                                         ,downloadButton("downloadPic", "download picture")
                                         ,h4('Due to Server compacity,the App may crash.Just refrsh the page if it crash')
                                         
                                         ),
                                tabPanel("photo editor",
                                         
                                         # Input: Simple integer interval ----
                                         sliderInput("img_height", "img_height:",
                                                     min = 400, max = 800,
                                                     value = 675),
                                         
                                         # Input: Decimal interval with step value ----
                                         sliderInput("img_width", "img_width:",
                                                     min = 300, max = 1500,
                                                     value = 1200),
                                         # Input: Decimal interval with step value ----
                                         sliderInput("Brightness", "Brightness:",
                                                     min = -1, max = 1,
                                                     value = 0,step=0.1),
                                         # Input: Decimal interval with step value ----
                                         sliderInput("Contrast", "Contrast:",
                                                     min = 0, max = 2,
                                                     value = 1,step=0.1),
                                         
                                         # Input: Decimal interval with step value ----
                                         sliderInput("Gamma_Correction", "Gamma Correction:",
                                                     min = 0, max = 2,
                                                     value = 1,step=0.1),
                                         
                                         radioButtons('rotation', 'rotation', c('normal'='normal',
                                                                                'flip'='flip'),
                                                      selected='normal') 
                                         
                                         
                                         
                                         
                                         )
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







