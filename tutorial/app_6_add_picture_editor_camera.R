#install.packages('pacman')

library(pacman)

library(keras)
#install_keras()



library(shiny)
p_load_gh("nstrayer/shinysense")
p_load_gh("bnosac/image/image.darknet")
library(ggplot2)
library(plotly)
library(dplyr)


#library(BiocManager)
#options(repos = BiocManager::repositories())


library(imager)
library(EBImage)
library(image.darknet)
library(shinybusy)
library(reshape2)
library(reticulate)
library(shinythemes)



###############  ui.R     ###########################
#  ui.R
ui <- fluidPage(add_busy_spinner(spin = "fading-circle"),
                
                # App title ----
                titlePanel(title=div(img(src="logo.jpg"),"Object detection  with Shiny")),
                
                # Sidebar layout with input and output definitions ----
                sidebarLayout(
                  
                  # Sidebar to demonstrate various slider options ----
                  sidebarPanel(
                    tabsetPanel(type = "tabs",
                                #######################    model input        ##########################
                                tabPanel("model",
                                         selectInput('model', 'model:', c('dog_cat_CNN_model','VGG16_dog_cat_cnn_model','mobilenet_model','resnet50_model','tiny_yolo'),selected = 'no model')
                                         ,actionButton("Run_model", "Run_model",class = "butt",)
                                         ,tags$head(tags$style(".butt{background-color:#DF3915;} .butt{color: #FFFFFF;}"))
                                         
                                         #,br(),br(),br()
                                         ,fileInput('input001', 'choose picture') 
                                         
                                         ,h6('Due to Server compacity,the App may crash.Just refrsh the page if it crash',style = "color:red")
                                         ,plotlyOutput("plot002")
                                ),
                                ##########################    picture edior       #######################
                                tabPanel("picture edior",
                                         
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
                                         
                                         ,downloadButton("downloadPic", "download picture")
                                         
                                         
                                         
                                         
                                )
                                
                                
                    )
                  ),
                  
                  # Main panel for displaying outputs ----
                  mainPanel(
                    
                    tabsetPanel(type = "tabs",
                                tabPanel("picture",
                                         #tableOutput('table001'),
                                         
                                         plotOutput('plot001',height= '500px' )
                                         
                                         
                                         
                                         
                                ),
                                
                                tabPanel("model_summary",
                                         
                                         tableOutput('table002')    ,
                                         verbatimTextOutput('model_summary')
                                         
                                ),
                                tabPanel("Camera",
                                         
                                         shinyviewr_UI("my_camera", height = '400px')  ,
                                         h2("Taken Photo:"),
                                         imageOutput("snapshot")
                                         #plotOutput('predPlot')
                                         
                                )
                                
                                
                                
                    )
                  )
                )
)


########################################################


###############  Server.R     ###########################




#  server.R
server <- function(input, output,session) {
  
  
  ################  myCamera
  myCamera <- callModule(
    shinyviewr,
    'my_camera',
    output_width = 400,
    output_height = 400
  )
  
  output$snapshot <- renderPlot({
    
    req(myCamera())
    plot(myCamera(), main = 'My Photo!')
    
  })
  
  v <- reactiveValues(counter = 1)
  observeEvent(myCamera(), {
    
    v$counter =2
    png(filename="cam.png")
    plot(myCamera(), main = 'My Photo!')
    dev.off()
    # make predictions then decode and print them
    
    
  })
  
  
  
  #############################################################
  
  
  #################  photo changer ############################## 
  data001=reactive({
    if(is.null(input$input001)==FALSE){
      im <- readImage(input$input001$datapath)
      
      #im <- load.image('dog_sample001.jpg')
    }
    else if(v$counter==2){
      
      im <- readImage('cam.png')
    }
    else{
      im <- readImage('dog_sample001.jpg')
    }
    
    after_im=((EBImage::resize(im,input$img_width,input$img_height) +input$Brightness)*input$Contrast)^input$Gamma_Correction 
    if (input$rotation=='normal'){
      after_im2=after_im
    }else{
      after_im2=flip(after_im)
    }
  })
  
  ###################### model 
  
    
    #######################################
    
    
 
  
  
  
  
  output$plot001=renderPlot({
    
    plot(data001())
  })
  #################    download pic   ######################################
  output$downloadPic <- downloadHandler(
    
    filename <- function() {
      paste("output", "jpg", sep=".")
    },
    
    content <- function(file) {
      writeImage(data001(), 'output.jpg', quality = 85)
      file.copy("output.jpg", file)
    }
    
  )
  
}


# Run the app ----
shinyApp(ui = ui, server = server)